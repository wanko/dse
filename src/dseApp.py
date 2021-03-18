import sys
from clingo import Application, clingo_main
from clingo.ast import parse_files, ProgramBuilder
from clingodl import ClingoDLTheory


class DSEApp(Application):
    def __init__(self):
        self.program_name = "Design Space Exploration with ASPmDL"
        self.version = "1.0"

    def main(self,ctl,files):
        thy = ClingoDLTheory()
        thy.register(ctl)
        with ProgramBuilder(ctl) as bld:
            parse_files(files, lambda ast: thy.rewrite_ast(ast, bld.add))

        ctl.ground([('base', [])])
        thy.prepare(ctl)
        ctl.solve(on_model=thy.on_model)

sys.exit(clingo_main(DSEApp(), sys.argv[1:]))