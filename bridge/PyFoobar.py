# This is a kind of façade to the real Python implementation
# Here, you must simply write the methods that interact with the
# Python class.

import objc
from Foundation import NSObject
from foobar import Foobar

class PyFoobar(NSObject):
    def init(self):
        self = super(PyFoobar, self).init()
        self.py = Foobar()
        return self

    @objc.signature('@@:')
    #-> index
    def index(self):
        return self.py.logfile

    @objc.signature('v@:')
    #-> dump
    def dump(self):
        print self.py.logfile
    
    @objc.signature('v@:')
    #-> printKeys
    def printKeys(self):
        print "%d elements" % (len(self.py.logfile))
        for i in self.py.logfile:
            print i

    @objc.signature('@@:i')
    #-> getCounters
    def getCounters_(self,row):
        print "Asking for array at %d position" % (row)
        counters = self.py.logfile[row]['value']
        print counters
        return counters


    #------------------------------------------------------------------------------------------------------
    # ObjC Protocol
    #------------------------------------------------------------------------------------------------------
    
    #@objc.signature('i@:')
    @objc.signature('i@:iB')
    #def count_SelectedElement_withFlag(self, selectedElement, isIndexTable):
    def count_withFlag_(self, selectedElement, isIndexTable):
        return self.py.count(selectedElement, isIndexTable)
    
    #
    # The number of underscores corresponds to the number of arguments
    # Refer to the PyObjC for more information on how to decrypt thist
    # f*ckin' convention.
    #
    # On the signature (NO DOCS)
    # void = v
    # Object = @
    # self = @:
    # integer = i
    # unsigned int = I
    # Boolean = B
    #
    @objc.signature('@@:@iiB')
    def stringAtColumn_andRow_selectedElement_withFlag_(self, column, row, selectedElement, isIndexTable):
        return self.py.object_at_columnrow(column, row, selectedElement, isIndexTable)
    
    @objc.signature('@@:i')
    def stringAtIndex_(self, index):
        return self.py.string_at_index(index)


