from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

ext_modules=[
    Extension("nessdbwrapper",
        sources=["nessdbwrapper.pyx"],
        libraries=["lib/nessdb"])
]

setup(
    name = "NessDB",
    cmdclass = {"build_ext": build_ext},
    ext_modules = ext_modules
)