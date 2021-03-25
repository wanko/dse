from clingo.symbol import Function, Number, SymbolType, Tuple_
from clingo.theory_atoms import TheoryTermType
from clingo.propagator import Propagator
from preferences import MaxPreference, SumPreference
from util import copy_symbol
from copy import copy

class Solution():
    def __init__(self,atoms,values):
        self.__atoms = atoms
        self.__values = values

    def atoms(self):
        return self.__atoms

    def values(self):
        return self.__values

class State():
    def __init__(self):
        self._values           = {}        # { name : value }
        self._solutions        = set()     # { solutions }
        self._previous_values  = {}        # { level : { name : value } }
        self._trail            = []        # [ literal ]
        self._stack            = []        # [ (level,index) ]

    def set_value(self,level,name,value):
        p = self._previous_values.setdefault(level,{})
        c = self._values
        if name not in p:
            if name in c: p[name] = c[name]
            else:         p[name] = None
        c[name] = value

    def __reset(self,level):
        p = self._previous_values
        c = self._values
        if level in p:
            for name, value in p[level].items():
                if value is None: del c[name]
                else:             c[name] = value
            del p[level]

    def backtrack(self,level):
        self.__reset(level)
        while self._stack[-1][0] != level: self._stack.pop()
        del self._trail[self._stack[-1][1]:] 
        self._stack.pop()

class ParetoPropagator(Propagator):
    def __init__(self,theory,mode):
        self._theory      = theory  # theory providing values
        self._preferences = {}      # { name : preference }
        self._l2p         = {}      # { literal : [preference] }
        self._states      = []      # [ state ]
        self._mode        = mode
        self._best_known  = None
        self._solutions   = set()

    def _state(self, thread_id):
        while len(self._states) <= thread_id:
            self._states.append(State())
        return self._states[thread_id]

    def _symbol_to_lit(self,symbol,init):
        for atom in init.symbolic_atoms.by_signature("_holds",2):
            if str(symbol) == str(atom.symbol.arguments[0]):
                return init.solver_literal(atom.literal)
        return None

    def save_best(self):
        self._solutions.add(copy(self._best_known))
        self._best_known = None

    def get_best(self):
        return self._best_known

    def get_solutions(self):
        solutions = set()
        remove    = set()
        for state in self._states:
            solutions = solutions.union(state._solutions)
        for solution in solutions:
            compare = set()
            compare = compare.union(solutions)
            compare.remove(solution)
            for solution2 in compare:
                worse  = False
                better = False
                for name in solution.values():
                    if solution.values()[name] > solution2.values()[name]: worse  = True
                    if solution.values()[name] < solution2.values()[name]: better = True
                if worse and not better:
                    remove.add(solution)
                if better and not worse:
                    remove.add(solution2)

        return solutions.difference(remove)

    def init(self, init):
        dl_lits = []
        for atom in init.theory_atoms:
            term = atom.term
            if term.name == "__diff_h" and len(term.arguments) == 0:
                lit = init.solver_literal(atom.literal)
                dl_lits.append(lit)
            if term.name == "__diff_b" and len(term.arguments) == 0:
                lit = init.solver_literal(atom.literal)
                dl_lits.append(lit)
                init.add_watch(lit)
                dl_lits.append(-lit)
                init.add_watch(-lit)

        for atom in init.symbolic_atoms.by_signature("_preference",2):
            name     = str(atom.symbol.arguments[0].name)
            type     = str(atom.symbol.arguments[1].name)
            if type == "max":
                self._preferences[name] = MaxPreference(name,type,self._theory)
                for lit in dl_lits:
                    self._l2p.setdefault(lit,[]).append(name)
            if type == "sum":
                self._preferences[name] = SumPreference(name,type)    

        for atom in init.symbolic_atoms.by_signature("_preference",5):
            lit  = self._symbol_to_lit(atom.symbol.arguments[3].arguments[0],init)
            if not lit: continue
            name = str(atom.symbol.arguments[0].name)
            if self._preferences[name].type() == "max":
                variable = self._theory.lookup_symbol(atom.symbol.arguments[4].arguments[0])
                if not variable: continue
                offset   = atom.symbol.arguments[4].arguments[1].number
                self._preferences[name].add_element((lit,variable,offset))
            if self._preferences[name].type() == "sum":
                weight = atom.symbol.arguments[4].arguments[0].number
                self._preferences[name].add_element((lit,weight))
            init.add_watch(lit)
            self._l2p.setdefault(lit,[]).append(name)

    def propagate(self, control, changes):
        state = self._state(control.thread_id)
        level = control.assignment.decision_level
        if len(state._stack) == 0 or state._stack[-1][0] < level:
            state._stack.append((level, len(state._trail)))
        state._trail.extend(changes)

        for lit in changes:
            for name in self._l2p[lit]:
                state._values.setdefault(name,None)
                preference = self._preferences[name]
                state.set_value(level,name,preference.update(control,changes,state._values[name]))
        if self._mode == "breadth":
            for solution in state._solutions:
                worse  = False
                better = False
                for name in state._values:
                    if state._values[name] == None: break
                    if state._values[name] > solution.values()[name]: worse  = True
                    if state._values[name] < solution.values()[name]: better = True
                if worse and not better:
                    control.add_nogood(state._trail) and control.propagate()
                    return
        elif self._mode == "depth":
            if self._best_known != None:
                worse  = False
                better = False
                for name in state._values:
                    if state._values[name] == None: break
                    if state._values[name] > self._best_known.values()[name]: worse  = True
                    if state._values[name] < self._best_known.values()[name]: better = True
                if (not better and worse) or (not better and not worse):
                    control.add_nogood(state._trail) and control.propagate()
                    return

            for solution in self._solutions:
                worse  = False
                better = False
                for name in state._values:
                    if state._values[name] == None: break
                    if state._values[name] > solution.values()[name]: worse  = True
                    if state._values[name] < solution.values()[name]: better = True
                if not (better and worse):
                    control.add_nogood(state._trail) and control.propagate()
                    return

    def check(self, control):
        state = self._state(control.thread_id)
        for solution in state._solutions:
            worse  = False
            better = False
            for name in state._values:
                if state._values[name] == None: break
                if state._values[name] > solution.values()[name]: worse  = True
                if state._values[name] < solution.values()[name]: better = True
            if better and not worse:
                state._solutions.remove(solution)

    def undo(self, thread_id, assign, changes):
        state = self._state(thread_id)
        level = assign.decision_level
        state.backtrack(level)

    def on_model(self, m):
        state = self._state(m.thread_id)
        m.extend([Function("pref", [Function(name), Function(self._preferences[name].type()), Number(value)])
                      for name, value in state._values.items()])
        if self._mode == "breadth": state._solutions.add(Solution([copy_symbol(atom) for atom in m.symbols(theory=True,shown=True)],copy(state._values)))
        elif self._mode == "depth": self._best_known = Solution([copy_symbol(atom) for atom in m.symbols(theory=True,shown=True)],copy(state._values))