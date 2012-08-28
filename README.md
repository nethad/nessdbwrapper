nessdbwrapper
=============

a python (cython) wrapper around nessDB (toy project to experiment with cython)

To build: 

First build checkout nessdb: `git submodule init`

`git submodule update`

and build it: In lib/nessdb execute `make`

Then build nessdbwrapper: In the root directory execute `python setup.py build_ext -i`

There is no 'clean' command, use: 

rm -rf build/ nessdbwrapper.c nessdbwrapper.so <db-basedir>

or: python setup.py clean