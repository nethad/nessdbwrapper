cdef extern from "include/util.h":
    cdef struct slice:
        char* data
        int len

cdef extern from "include/db.h":
    cdef struct nessdb:
        pass

    nessdb* db_open(char* basedir, bint is_log_recovery)
    int db_get(nessdb* db, slice* sk, slice* sv)
    bint db_exists(nessdb* db, slice* sk)
    bint db_add(nessdb* db, slice* sk, slice* sv)
    void db_remove(nessdb* db, slice* sk)
    char* db_info(nessdb* db)
    void db_close(nessdb* db)