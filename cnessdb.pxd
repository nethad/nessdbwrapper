#cdef extern from "time.h" nogil:
#    ctypedef long time_t

cdef extern from "lib/nessdb/engine/util.h":
    cdef struct slice:
        char* data
        int len

    cdef struct buffer:
        pass

cdef extern from "lib/nessdb/engine/index.h":
    cdef struct index:
        pass

    long index_allcount(index* idx)

cdef extern from "lib/nessdb/engine/db.h":
    cdef struct nessdb:
        index* idx
#        buffer* buf
#        time_t start_time

    nessdb* db_open(char* basedir, bint is_log_recovery)
    int db_get(nessdb* db, slice* sk, slice* sv) except -1 #Return status: -1=error 0=NULL 1=exists
    bint db_exists(nessdb* db, slice* sk)
    bint db_add(nessdb* db, slice* sk, slice* sv) except 0 #Return status: 1=ok 0=error
    void db_remove(nessdb* db, slice* sk)
    char* db_info(nessdb* db)
    void db_close(nessdb* db)

