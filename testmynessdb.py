__author__ = 'thomas'

from pynessdb import NessDB

n = NessDB("testdir", False)

key1 = "key"
value1 = "lala"
print n.add(key1, value1)
print "key '%s' exists: %s" % (key1, n.key_exists(key1))
print n.get(key1)

key2 = "blah"
value2 = "foo"
print n.add(key2, value2)
print "key '%s' exists: %s" % (key2, n.key_exists(key2))
print n.get(key2)

n.remove(key1)
n.remove(key2)

n.info()

print "Done."
