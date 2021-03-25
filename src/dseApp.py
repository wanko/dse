import sys
from clingo import Application, clingo_main
from clingo.ast import parse_files, ProgramBuilder
from clingodl import ClingoDLTheory
from paretoPropagator import ParetoPropagator


class DSEApp(Application):
    def __init__(self):
        self.program_name = "Design Space Exploration with ASPmDL"
        self.version      = "1.0"
        self.theory       = None
        self.propagator   = None

    def on_model(self,m):
        self.theory.on_model(m)
        self.propagator.on_model(m)
    
    def print_front(self,r):
        print("")
        if r.interrupted: print("Best known Pareto front:")
        else:             print("Pareto front:")
        solutions = self.propagator.get_solutions() 
        n = 1
        for solution in solutions:
            print("Answer",n)
            print(" ".join([str(atom) for atom in solution.atoms()]))
            n += 1

    def main(self,ctl,files):
        ctl.configuration.solve.models = 0

        thy = ClingoDLTheory()
        self.theory = thy
        thy.register(ctl)
        with ProgramBuilder(ctl) as bld:
            parse_files(files, lambda ast: thy.rewrite_ast(ast, bld.add))

        pareto_propagator = ParetoPropagator(thy)
        self.propagator = pareto_propagator
        ctl.register_propagator(pareto_propagator)

        ctl.ground([('base', [])])
        thy.prepare(ctl)
        ctl.solve(on_model=self.on_model,on_finish=self.print_front)

sys.exit(clingo_main(DSEApp(), sys.argv[1:]))