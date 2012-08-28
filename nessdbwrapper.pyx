cimport cnessdb
from libc.stdlib cimport malloc, free

cdef class NessDB:
    cdef cnessdb.nessdb* _c_nessdb

    def __init__(self, basdir):
        pass

    def __cinit__(self, basedir):
        self._c_nessdb = cnessdb.db_open(basedir, False)

    def __dealloc__(self):
            self.close()

    cpdef close(self):
        if self._c_nessdb is not NULL:
            cnessdb.db_close(self._c_nessdb)
            self._c_nessdb = NULL

    def add(self, key, value):
        localKey = str(key)
        cdef cnessdb.slice k
        k.data = localKey
        k.len = len(localKey)
        localVal = str(value)
        cdef cnessdb.slice v
        v.data = localVal
        v.len = len(localVal)

        return cnessdb.db_add(self._c_nessdb, &k, &v)

    def get(self, key):
        localKey = str(key)
        cdef cnessdb.slice k
        k.data = localKey
        k.len = len(localKey)
        cdef cnessdb.slice v
        cnessdb.db_get(self._c_nessdb, &k, &v)
        cdef char* cvalue = v.data
        cdef int clen = v.len
        return cvalue[:clen].decode('UTF-8')

    def key_exists(self, key):
        localKey = str(key)
        cdef cnessdb.slice k
        k.data = localKey
        k.len = len(localKey)
        return cnessdb.db_exists(self._c_nessdb, &k)

    def remove(self, key):
        localKey = str(key)
        cdef cnessdb.slice k
        k.data = localKey
        k.len = len(localKey)
        cnessdb.db_remove(self._c_nessdb, &k)

    def info(self):
        cdef char* info = cnessdb.db_info(self._c_nessdb)
        print info.decode('UTF-8')
