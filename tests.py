__author__ = 'daniel'

import unittest
from pynessdb import NessDB
from os import sep
from shutil import rmtree
from os.path import isdir
from tempfile import gettempdir
from time import time

class TestNessDB(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        try:
            cls.dirname = ''.join((gettempdir(), sep, 'nessdb-', str(time()).replace('.', '')))
            cls.db = NessDB(cls.dirname, False)
        except:
            if isdir(cls.dirname):
                rmtree(cls.dirname)
            raise

    @classmethod
    def tearDownClass(cls):
        try:
            if cls.db is not None:
                cls.db.close()
        finally:
            if isdir(cls.dirname):
                rmtree(cls.dirname)

    def test_add(self):
        key = 'foo'
        value = 'bar'
        self.assertTrue(self.db.add(key, value), "failed to add '%s'." % key)
        self.assertTrue(self.db.key_exists(key), "'%s' does not exist in the database." % key)

    def test_get(self):
        key = 'hello'
        value = 'world'
        self.db.add(key, value)
        ret = self.db.get(key)
        self.assertEqual(value, ret, "value for '%s' is wrong. Expected '%s' but was '%s'" % (key, value, ret))

    def test_remove(self):
        key = 'bonjour'
        value = 'monde'
        self.db.add(key, value)
        self.assertTrue(self.db.key_exists(key), "'%s' does not exist in the database." % key)
        self.db.remove(key)
        self.assertFalse(self.db.key_exists(key), "'%s' was not removed from the database." % key)

if __name__ == '__main__':
    unittest.main()