nessdbwrapper
=============

a python (cython) wrapper around nessDB (toy project to experiment with cython)

To build: python setup.py build_ext -i
There is no 'clean' command, use: rm -rf build/ nessdbwrapper.c nessdbwrapper.so <db-basedir>