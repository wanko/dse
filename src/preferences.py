class MaxPreference():
    def __init__(self,name,type,theory):
        self.__name    = name
        self.__type    = type
        self.__l2e     = {}       # { literal : [( variable name, offset)] }
        self.__theory  = theory   

    def add_element(self,element):
        assert len(element) == 3
        self.__l2e.setdefault(element[0],[]).append((element[1],element[2]))

    def name(self):
        return self.__name

    def type(self):
        return self.__type

    def update(self,control,changes,value):
        max = float('-inf')
        
        for lit in self.__l2e:
            if control.assignment.is_true(lit):
                for variable, offset in self.__l2e[lit]:
                    if self.__theory.has_value(control.thread_id,variable):
                        assignment = self.__theory.get_value(control.thread_id,variable)
                        if max < assignment + offset:
                            max =  assignment + offset
                            
        if max == float('-inf'): 
            return 0 
        else:
            return int(max)

class SumPreference():
    def __init__(self,name,type):
        self.__name  = name
        self.__type  = type
        self.__l2e   = {}    # { literal : [weight] }

    def add_element(self,element):
        assert len(element) == 2
        self.__l2e.setdefault(element[0],[]).append(element[1])

    def name(self):
        return self.__name

    def type(self):
        return self.__type

    def update(self,control,changes,value):
        if value: sum = value
        else:     sum = 0
        
        for lit in changes:
            if control.assignment.is_true(lit):
                if lit in self.__l2e:
                    for summand in self.__l2e[lit]:
                        sum += summand
        
        return sum