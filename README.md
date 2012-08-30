pyNessDB
=============

a python (cython) wrapper around nessDB (toy project to experiment with cython)

To build: 

First build checkout nessdb: `git submodule init`

`git submodule update`

and build it: In lib/nessdb execute `make`

Then build pynessdb: In the root directory execute `python setup.py build_ext -i`

To clean: python setup.py clean

Run unit tests: `python tests.py`

NOTE: Before executing you may have to set your LD_LIBRARY_PATH environment variable to include the lib/nessdb directory:
`export LD_LIBRARY_PATH=./lib/nessdb:$LD_LIBRARY_PATH`