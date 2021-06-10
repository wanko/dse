from clingo.symbol import Function, Number, SymbolType, Tuple_
from clingo.theory_atoms import TheoryTermType
from clingo.propagator import Propagator, PropagatorCheckMode
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

class ParetoPropagator(Propagator):
    def __init__(self,theory,mode):
        self._theory        = theory  # theory providing values
        self._preferences   = {}      # { name : preference }
        self._mode          = mode
        self._best_known    = None
        self._solutions     = set()
        self._current_front = {}      # { thread : set of Solution }
        self._values        = {}      # { thread : values }
        self._relevant_lits = set()

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
        for id in self._current_front:
            solutions = solutions.union(self._current_front[id])
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
        init.check_mode = PropagatorCheckMode.Both

        dl_required = False
        for atom in init.symbolic_atoms.by_signature("_preference",2):
            name     = str(atom.symbol.arguments[0].name)
            type     = str(atom.symbol.arguments[1].name)
            if type == "max":
                self._preferences[name] = MaxPreference(name,type,self._theory)
                dl_required = True
            if type == "sum":
                self._preferences[name] = SumPreference(name,type)    
        
        if dl_required:
            for atom in init.theory_atoms:
                term = atom.term
                if term.name == "__diff_h" and len(term.arguments) == 0:
                    lit = init.solver_literal(atom.literal)
                    self._relevant_lits.add(lit)
                if term.name == "__diff_b" and len(term.arguments) == 0:
                    lit = init.solver_literal(atom.literal)
                    self._relevant_lits.add(lit)
                    self._relevant_lits.add(-lit)

        for atom in init.symbolic_atoms.by_signature("_preference",5):
            lit  = self._symbol_to_lit(atom.symbol.arguments[3].arguments[0],init)
            if not lit: continue
            self._relevant_lits.add(lit)
            name = str(atom.symbol.arguments[0].name)
            if self._preferences[name].type() == "max":
                variable = self._theory.lookup_symbol(atom.symbol.arguments[4].arguments[0])
                if not variable: continue
                offset   = atom.symbol.arguments[4].arguments[1].number
                self._preferences[name].add_element((lit,variable,offset))
            if self._preferences[name].type() == "sum":
                weight = atom.symbol.arguments[4].arguments[0].number
                self._preferences[name].add_element((lit,weight))

    def check(self, control):
        values = self._values.setdefault(control.thread_id,{})
        for name in self._preferences:
            preference = self._preferences[name]
            values[name] = preference.update(control,control.assignment,None)
        if self._mode == "breadth":            
            remove = set()
            current_front = self._current_front.setdefault(control.thread_id,set())
            for solution in current_front:
                worse  = False
                better = False
                for name in values:
                    if values[name] == None: 
                        better = True
                        break
                    if values[name] > solution.values()[name]: worse  = True
                    if values[name] < solution.values()[name]: better = True
                if worse and not better and not control.assignment.is_total:
                    nogood = [lit for lit in control.assignment if lit in self._relevant_lits]
                    control.add_nogood(nogood) and control.propagate()
                    return
                if better and not worse and control.assignment.is_total:
                    remove.add(solution)
            current_front.difference(remove)
        elif self._mode == "depth":
            if self._best_known != None:
                worse  = False
                better = False
                for name in values:
                    if values[name] == None: break
                    if values[name] > self._best_known.values()[name]: worse  = True
                    if values[name] < self._best_known.values()[name]: better = True
                if worse and not control.assignment.is_total:
                    nogood = [lit for lit in control.assignment if lit in self._relevant_lits]
                    control.add_nogood(nogood) and control.propagate()
                    return
                if not (better and not worse) and control.assignment.is_total:
                    nogood = [lit for lit in control.assignment if lit in self._relevant_lits]
                    control.add_nogood(nogood) and control.propagate()
                    return

            for solution in self._solutions:
                worse  = False
                better = False
                for name in values:
                    if values[name] == None: break
                    if values[name] > solution.values()[name]: worse  = True
                    if values[name] < solution.values()[name]: better = True
                if not (better and worse):
                    nogood = [lit for lit in control.assignment if lit in self._relevant_lits]
                    control.add_nogood(nogood) and control.propagate()
                    return

    def on_model(self, m):
        values = self._values[m.thread_id]
        m.extend([Function("pref", [Function(name), Function(self._preferences[name].type()), Number(value)])
                      for name, value in values.items()])
        if self._mode == "breadth": self._current_front.setdefault(m.thread_id,set()).add(Solution([copy_symbol(atom) for atom in m.symbols(theory=True,shown=True)],copy(values)))
        elif self._mode == "depth": self._best_known = Solution([copy_symbol(atom) for atom in m.symbols(theory=True,shown=True)],copy(values))
