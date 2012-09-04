from cnessdb cimport *

cdef class NessDB:
    """
    A Python wrapper for nessDB (https://github.com/shuttler/nessDB).
    """

    cdef nessdb* _c_nessdb
    cdef bytes basedir

    #init just defined for nice code completion.
    def __init__(self, basedir, use_log_recovery):
        """
        Opens a new database in the file system location identified by 'basedir' (relative to the execution directory).
        Set 'use_log_recovery' to 'True' to use log-file based recovery after database crashes (impedes performance),
        'False' does not use recovery.
        """
        pass

    def __cinit__(self, basedir, use_log_recovery):
        self.basedir = self._encode_as_utf8_string(basedir)
        self._c_nessdb = db_open(self.basedir, use_log_recovery)

    def __dealloc__(self):
        self.close()

    cpdef close(self):
        """
        Close the database and free up memory, if a database is opened.
        """
        if self._c_nessdb is not NULL:
            db_close(self._c_nessdb)
            self._c_nessdb = NULL

    def add(self, key, value):
        """
        Add a new entry.
        """
        self._ensure_db_exists()
        key = self._encode_as_utf8_string(key)
        value = self._encode_as_utf8_string(value)
        cdef slice k = slice(data=key, len=len(key))
        cdef slice v = slice(data=value, len=len(value))
        return db_add(self._c_nessdb, &k, &v)

    def get(self, key):
        """
        Retrieve the value for 'key'. Returns 'None' if no value exists.
        """
        self._ensure_db_exists()
        key = self._encode_as_utf8_string(key)
        cdef slice k = slice(data=key, len=len(key))
        cdef slice v
        status = db_get(self._c_nessdb, &k, &v)
        if status is 0:
            return None

        return (v.data[:v.len]).decode('UTF-8')

    def key_exists(self, key):
        """
        Check if a value for 'key' exists in the database.
        """
        self._ensure_db_exists()
        key = self._encode_as_utf8_string(key)
        cdef slice k = slice(key, len(key))
        return db_exists(self._c_nessdb, &k)

    def remove(self, key):
        """
        Remove the value for 'key', if it exists.
        """
        self._ensure_db_exists()
        key = self._encode_as_utf8_string(key)
        cdef slice k = slice(key, len(key))
        db_remove(self._c_nessdb, &k)

    def info(self):
        """
        Print database information and statistics.
        """
        self._ensure_db_exists()
        cdef bytes info = db_info(self._c_nessdb)
        print info.decode('UTF-8')

    cdef void _ensure_db_exists(self) except *:
        if(self._c_nessdb is NULL):
            raise ValueError('NessDB is not properly initialized or closed.')

    def _encode_as_utf8_string(self, s):
        return str(s).encode('UTF-8')
