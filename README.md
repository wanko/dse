# Pareto optimization for Design Space Exploration

This project allows for calculating Pareto optimal models over predefined preference types for ASPmDL programs. 
This can be done in depth first, where the best known model is improved in a branch and bound fashion until no better model can be obtained,
or breadth first, where an archive of solutions is improved simultaneously until the search space is exhausted and the archive contains the Pareto front.

### Requirements
  - clingo 5.5.0:
    - Most convenient way to install is conda via
      `conda install clingo -c potassco/label/dev`
    - Please consult the following resource for further information [clingo](https://github.com/potassco/clingo)
  - clingo-dl 1.2.0:
    - Most convenient way to install is conda via
      `conda install clingo-dl -c potassco/label/dev`
    - Please consult the following resource for further information [clingo-dl](https://github.com/potassco/clingoDL)
  - Python >=3.9

### Usage

    python src/dseApp.py [CLINGO AND CLINGO-DL OPTIONS]... [--dse-mode MODE] [FILES]

Option `--dse-mode MODE` can be used to switch between depth first (MODE=depth),
and breadth based approach (MODE=breadth), by default MODE=breadth.
For the depth mode, the clingo parameter for number of models is used to determine how many Pareto optimal models are iterated, as usual 0 means all models.
The breadth approach ignores this options, as it always exhausts the search space. Add flag `--duplicate-vectors` to keep several solutions with the same quality vector in breadth mode, by default only the first is stored.

### Example

    python src/dseApp.py encodings/encoding_xyz.lp encodings/priorities.lp instances/test.lp encodings/preferences.lp -q --dse-mode=depth 2

### Preferences
The preference definitions are based on translated `asprin` preferences programs. 
More information about `asprin` can be found [here](http://www.cs.uni-potsdam.de/wv/pdfformat/brderosc15a.pdf) 
and the newest version of the system may be installed via 

    conda install asprin -c potassco

Note that we implement value minimization and Pareto aggregation of all preference definitions.

#### `max`
Depends on clingo-dl
Preference definition:

    _preference(<name>,max)
    _preference(<name>,...,...,for(atom(<a>)),(<variable>,<offset>,<a>))
    _holds(atom(<a>),0) :- <a>.
    
The objective value for a preference of type `max` of a model is obtained by calculating the maximum of the integer variable `<variable>` plus `<offset>` if condition `<a>` is satisfied by the model.

#### `sum`
Preference definition:

    _preference(<name>,sum)
    _preference(<name>,...,...,for(atom(<a>)),(<value>,<a>))
    _holds(atom(<a>),0) :- <a>.
    
The objective value for a preference of type `sum` of a model is obtained by summing up `<value>` if condition `<a>` is satisfied by the model.
