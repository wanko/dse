import sys
from clingo import Application, Flag, clingo_main
from clingo.ast import parse_files, ProgramBuilder
from clingodl import ClingoDLTheory
from paretoPropagator import ParetoPropagator


class DSEApp(Application):
    def __init__(self):
        self.program_name      = "Design Space Exploration with ASPmDL"
        self.version           = "1.0"
        self.theory            = None
        self.propagator        = None
        self.mode              = "breadth"
        self.nr_models         = 0
        self.duplicate_vectors = Flag(False)
        self.dl_propagation_mode  = "no"

    def _parse_mode(self):
        def parse(value):
            if not isinstance(value,str) or value not in ["depth","breadth"]: return False
            self.mode = value
            return True
        return parse

    def _parse_nr_models(self):
        def parse(value):
            nr_models = int(value)
            self.nr_models = nr_models
            return True
        return parse

    def _parse_propagation_mode(self):
        def parse(value):
            if not isinstance(value,str) or value not in ["no","inverse","partial","partial+","zero","full"]: return False
            self.dl_propagation_mode = value
            return True
        return parse

    def _on_statistics(self,step,accumulation):
        self.theory.on_statistics(step,accumulation)
        self.propagator._on_statistics(step,accumulation)

    def on_model(self,m):
        self.theory.on_model(m)
        self.propagator.on_model(m)
    
    def print_front(self,r):
        if r.unsatisfiable: return
        print("")
        if r.interrupted: print("Search interrupted: Approximate Pareto front:")
        else:             print("Pareto front:")
        solutions = self.propagator.get_solutions() 
        n = 1
        for solution in solutions:
            print("Answer",n)
            print(" ".join([str(atom) for atom in solution.atoms()]))
            n += 1
    
    def print_single(self,n,r):
        if r.unsatisfiable: return
        print("")
        if r.interrupted: print("Currently best:")
        else:             print("Pareto optimum found:")
        solution = self.propagator.get_best()
        print("Answer",n)
        print(" ".join([str(atom) for atom in solution.atoms()]))
        n += 1

    def register_options(self, options):
        options.add(
            "Design Space Exploration", "dse-mode",
            "Select mode, either simultaneously improving the whole Pareto front (breadth), or calculating certain number of Pareto optimal models (depth). Default: breadth",
            self._parse_mode())  
        options.add_flag(
            "Design Space Exploration", "duplicate-vectors",
            "During breadth-first search, keep solutions with same quality vector",
            self.duplicate_vectors
        )
        options.add(
            "Clingo.DL Options", "propagate",
            "Set propagation mode [no]",
            self._parse_propagation_mode())  

    def validate_options(self):
        if self.mode == "depth" and self.duplicate_vectors:
            print("Depth-first search does not allow for keeping solutions with same quality vector")
            return False
        return True

    def main(self,ctl,files):
        if self.mode == "depth":
            self.nr_models = abs(int(ctl.configuration.solve.models))
        ctl.configuration.solve.models = 0

        thy = ClingoDLTheory()
        self.theory = thy
        thy.register(ctl)
        with ProgramBuilder(ctl) as bld:
            parse_files(files, lambda ast: thy.rewrite_ast(ast, bld.add))

        pareto_propagator = ParetoPropagator(thy,self.mode,self.duplicate_vectors)
        self.propagator = pareto_propagator
        ctl.register_propagator(pareto_propagator)

        ctl.ground([('base', [])])
        thy.prepare(ctl)
        thy.configure("propagate",self.dl_propagation_mode)

        if self.mode == "breadth":
            ctl.solve(on_model=self.on_model, on_finish=self.print_front, on_statistics=self._on_statistics)
        elif self.mode == "depth":
            models = 0
            while models < self.nr_models or self.nr_models == 0:
                r = ctl.solve(on_model=self.on_model, on_finish=lambda m: self.print_single(models+1,m), on_statistics=self._on_statistics)
                if r.unsatisfiable: return
                models += 1
                self.propagator.save_best()

sys.exit(clingo_main(DSEApp(), sys.argv[1:]))