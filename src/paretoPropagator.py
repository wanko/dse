from clingo.symbol import Function, Number, SymbolType, Tuple_
from clingo.theory_atoms import TheoryTermType
from clingo.propagator import Propagator

class Preference():
    def __init__(self,name,type):
        self.__name  = name
        self.__type  = type
        self.__l2w   = {}    # { literal : [weight] }

    def add_weight(self,literal,weight):
        self.l2w.setdefault(literal,[]).append(weight)

    def get_weight(self,literal):
        return self.l2w[literal]

    def name(self):
        return self.__name

    def type(self):
        return self.__type

class Solution():
    def __init__(self,atoms,values):
        self.__atoms = atoms
        self.__values = values

    def atoms(self):
        return self.__atoms

    def values(self):
        return self.__values

class State():
    def __init__():
        self.__values = {}           # { name : value }
        self.__previous_values = {}  # { level : { name : value } }
        self.__solutions = set()     # { solution }

    def set_value(self,level,name,value):
        self.__previous_values.setdefault(level,{})[name] = value
        self.__values[name] = value

class ParetoPropagator(Propagator):
    def __init__(self):
        self._preferences = [] # [ preference ]
        self._l2p         = {} # { literal : [preference] }
        self._states      = [] # [ state ]

    def _state(self, thread_id):
        while len(self._states) <= thread_id:
            self._states.append(State())
        return self._states[thread_id]

    def init(self, init):
        pass

    def propagate(self, control, changes):
        pass

    def undo(self, thread_id, assign, changes):
        self._state(thread_id).backtrack(assign.decision_level)

    def on_model(self, model):
        pass
