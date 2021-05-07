This is a tool to create a supervisor using LTL expressions.

1.compiling
    Before using this tool, you need to compile "scheck2", a tool that converts LTL expressions to automata.
    pleanse execute the following two commands.

    -----------------------
    >make clean
    >make
    -----------------------
    If you do not run "make clean", the linker may fail.


2.How to use
    1.Write the LTL expression in a text file.
        *The input of scheck2 is post-qualified. (Example: "p1 U p2" changes to "U p1 p2".)
    2.Place a text file with the LTL expression in the Text folder.
        *For example, if the file of'txtname'is not directly under the Text folder but under the 'A' folder in the Text folder, set'txtname' to'A/{text name}'.
    3.Prepare a text file in which transition labels are separated by line breaks.
        *Do not prefix p in the proposition of this text file.
    4.Put the text file of 3. in the place where the path passes in MatlabTCT.
    5.Call the scheck2 function in Matlab. However, select the file 1. for the second argument and the file 3. for the third argument.

    scheck2 function needs five arguments below
        1.the name of the automaton to be created
        2.the name of the text in which the LTL expression is written('.txt' is not needed )
        3.the name of the text in which the transition label is written('.txt' is not needed )
        4.whether or not to make all states accepted
        5.Whether or not to self-loop the tautology after satisfying the formula


3.Samples
    There are 4 samples in the package.
    The model for each sample is described in Chapter 5 of the following paper.

    Shu Hashimoto,『離散事象システムのスーパーバイザ制御理論におけるLTLモデリングに関する研究』,2021
