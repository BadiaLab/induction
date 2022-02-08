# Induction to BadiaLab (work in progress)

# Initial steps
 1. Sign-in to [Github](https://github.com/) (i.e., create an account)
 2. Ask for invitation to [BadiaLab](https://github.com/BadiaLab) Github organization. How? Write an e-mail either to `alberto.martin@monash.edu` or `santiago.badia@monash.edu` with your Github user.
 3. Generate a pair of ssh keys on your local computer, and install the public key in Github. See instructions [here](https://www.inmotionhosting.com/support/server/ssh/how-to-add-ssh-keys-to-your-github-account/) for more details.

# Coding 

1. Follow the introduction to the Unix Shell tutorial. [here](https://github.com/MonashMath/SCI1022/blob/master/Unix-CLI.md) (if not familiarized)
2. Follow the introduction to version control with Git tutorial [here](https://github.com/MonashMath/SCI1022/blob/master/Git.md) (if not familiarized)
3. Install Julia. [here](https://github.com/gridap/Gridap.jl/wiki/Start-learning-Julia)
4. Introduction to Julia programming language [here](https://juliaacademy.com/p/intro-to-julia) . Free course, although you have to register before. Also it is a good resource the Julia documentation, but highly advanced! [here](https://docs.julialang.org/en/v1/)
5. In order to write "good" (e.g., performant, general, abstract, etc.) code with Julia is very important that you familiarize with two main concepts: (1) **multiple type dispatching** (see [here](https://docs.julialang.org/en/v1/manual/methods/) and references therein.). (2) Performance pitfalls caused by the so-called **type instability problem** (see [here](https://docs.julialang.org/en/v1/manual/performance-tips/#man-code-warntype) and [here](https://discourse.julialang.org/t/dynamic-dispatch/6963/2?u=amartinhuertas)). The ["performance tips"](https://docs.julialang.org/en/v1/manual/performance-tips/) page on the Julia documentation is also very useful and well worths a detailed read and incorporation of the strategies there to your coding. Understanding these two concepts will help you a lot, among others, in determining when it is needed/convenient from the performance POV to annotate function arguments with their types (and type parameters, if any). 
6. Set up a development workflow (coding, testing, debugging, etc.) for Julia using Visual Studio Code. [here](https://github.com/gridap/Gridap.jl/wiki/Visual-Studio-Code-as-Julia-IDE). **VERY IMPORTANT**: Install `Revise.jl` Julia package early so that you can re-compile code dynamically while developing, without the need to close and re-open the Julia REPL. See [here](https://pkgdocs.julialang.org/v1/) for instructions needed for installing packages.

# Updating Julia

The script `jill.py` available on their GitHub repos [here](https://github.com/johnnychen94/jill.py) can help in automatically updating Julia by a single line of command on the terminal. The only thing we need to do after installing the `jill.py` package (using the instructions given on the `jill.py` GitHub page) is to check the version of Julia we would like to install from the Julia Downloads section [here](https://julialang.org/downloads/) (usually either the LTS release or the current stable release.), and then run (taking the example of version `1.6.5` of Julia)

```shell
$ jill install 1.6.5
```
At the the time of writing, the other commands mentioned on the `jill.py` GitHub page (especially `$ jill install`, `$ jill install 1.6` (need a specific version like `1.6.5`, like the command above which works!)) don't work. 

The script keeps the earlier versions of Julia present on the machine. 

# Gridap.jl 

1. [Start learning Gridap](https://github.com/gridap/Gridap.jl/wiki/Start-learning-Gridap)

# Finite Elements 
 1. Ern & Guermond book.
 2. Santi's Lecture notes on Finite Element methods. MTH-4321, MTH-5321
 3. Gentle introduction to FEM Lecture notes [here](https://team-pancho.github.io/documents/anIntro2FEM_2015.pdf). Chapters 1-5.
 4. Claes Johnson book on Finite Elements. [here](https://www.booktopia.com.au/numerical-solution-of-partial-differential-equations-by-the-finite-element-method-claes-johnson/book/9780486469003.html?source=pla&gclid=CjwKCAiA78aNBhAlEiwA7B76pyECVNAow3Euugh0nZIWJ1C3O-n8rQAhK3GrEWuYJkErXaPqSvaMdhoCH1sQAvD_BwE)
 5. Imperial College FEM course. Available [here](https://finite-element.github.io/)

# Automated handling of bibliographics references 

Use the code available at the following repository: https://github.com/BadiaLab/BibHandler.jl

# HPC cluster (Monarch) for medium computational demands

(only when you need it)

1. Apply for an account. How? Follow the instructions [here](https://docs.monarch.erc.monash.edu/MonARCH/requesting-an-account.html). In step number 3., you have to join the `pMona0083` project.
2. Follow the instructions [here](https://github.com/gridap/GridapDistributed.jl/wiki/Monarch-(Monash)-Useful-links,-commands,-and-workflows)

# Writing technical documents (articles)

* We have a LaTeX template [here](https://github.com/BadiaLab/induction/blob/main/assets/report.tex) that you can use to write your articles/reports. The template  uses the `biblatex` package, and is to be compiled with `lualatex`+`biber`, 
* We highly recommend to use VSCode with the [Latex Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) extension to edit tex source files.
* We **strongly** encourage you to keep some research diary or notes about meetings, discussions, etc. LaTeX is probably too much for these purposes. One nice solution is to write the notes in markdown using `Markdown+Math` package in `VSCode` for math.
