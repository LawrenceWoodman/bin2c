bin2c
=====
A Tcl script to convert an input file into a C array for inclusion in a C source file.

The output is similar to the Unix command `xxd -i`

Requirements
------------
*  Tcl

Usage
-----

To convert a file `myfile.bin` to a C array called `myfile_bin` and output this to a file called `myfile.bin.h` use as follows:

    $ ./bin2c.tcl myfile.bin myfile_bin myfile.bin.h

or

    $ tclsh bin2c.tcl myfile.bin myfile_bin myfile.bin.h

If you omit the final argument (`myfile.bin.h` above) then the output will be to stdout.

Testing
-------
There is a testsuite in `tests/`.  To run it:

    $ tclsh tests/bin2c.test.tcl

Contributions
-------------
If you want to improve this script make a pull request to the [repo](https://github.com/LawrenceWoodman/bin2c) on github.  Please put any pull requests in a separate branch to ease integration and add a test to prove that it works.

Licence
-------
Copyright (C) 2013, Lawrence Woodman <http://techtinkering.com>

This software is licensed under an MIT Licence.  Please see the file, LICENCE.md, for details.
