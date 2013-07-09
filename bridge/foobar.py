# This is the real implementation in Python of the
# class you want to work in the plugin with the ObjC code.
# The only extrange method id the init.
# All functions accept 'self' as first argument.

class Foobar(object):
    #-----------------------------------------------------------------
    #
    #-----------------------------------------------------------------
    def __init__(self):
        self.logfile=[]
        counters=[]
        md={}
        # Add the counters and values array to 'counters' array.
        md={'counter':'DISCARDED_PDC_NETWORK_EVENT', 'value':'98'}
        counters.append(md)
        md={}
        md={'counter':'MAP_INPUT_RECORDS', 'value':'3386'}
        counters.append(md)
        md={}
        md={'counter':'MAP_OUTPUT_RECORDS', 'value':'3288'}
        counters.append(md)
        md={}
        md={'counter':'PDC_EVENT_INVALID_CELLID', 'value':'98'}
        counters.append(md)
        # Add the Index key for array of references to arrays 'logfile'
        md={}
        md={'stage':'ParsePDCEvents', 'value':counters}
        self.logfile.append(md)
        print "Added one counter file"
        
        counters=[]
        md={}
        md={'counter':'DISCARDED_SUBSCRIBERS', 'value':'50'}
        counters.append(md)
        md={}
        md={'counter':'MAP_INPUT_RECORDS', 'value':'3333'}
        counters.append(md)
        md={}
        md={'counter':'MAP_OUTPUT_RECORDS', 'value':'3223'}
        counters.append(md)
        # Add the Index key for array of references to arrays 'logfile'
        md={}
        md={'stage':'ParseCRMSubscribers', 'value':counters}
        self.logfile.append(md)
        print "Added one counter file"
        
        counters=[]
        md={}
        md={'counter':'MAP_INPUT_RECORDS', 'value':'5555'}
        counters.append(md)
        md={}
        md={'counter':'MAP_OUTPUT_RECORDS', 'value':'5500'}
        counters.append(md)
        # Add the Index key for array of references to arrays 'logfile'
        md={}
        md={'stage':'ParseUCRInformation', 'value':counters}
        self.logfile.append(md)
        print "Added one counter file"
        print "count = %d" % (self.count(-1, True))

    
    #-----------------------------------------------------------------
    # 'isIndexTable' indicates whether I'm requesting the length of
    # the table that hold the indices.
    # 'selectedElement' is the index selected. -1 indicates none.
    #-----------------------------------------------------------------
    def count(self, selectedElement, isIndexTable):
        if (isIndexTable == True):
            return len(self.logfile)
        if (selectedElement == -1):
            return 0
        return len(self.logfile[selectedElement]['value'])
    
    #-----------------------------------------------------------------
    #
    #-----------------------------------------------------------------
    def object_at_columnrow(self, column, row, selectedElement, isIndexTable):
        print "Asking for %s col, %d row, selectedElement = %d (isIndexTable=%d)" %\
            (column, row, selectedElement, isIndexTable)
        
        if (isIndexTable):
            return self.logfile[row][column]
        
        try:
            counters = self.logfile[selectedElement]['value']
            rowData = counters[row]
        except IndexError:
            print "CAUGHT Index exception!"

        return rowData[column]
    
    #-----------------------------------------------------------------
    #
    #-----------------------------------------------------------------
    def string_at_index(self, index):
        return self.logfile[index]['stage']



class OldFooBar(object):
    def __init__(self):
        self.counters=[]
        md={}
        md={'counter':'DISCARDED_PDC_NETWORK_EVENT', 'value':'98'}
        self.counters.append(md)
        md={}
        md={'counter':'MAP_INPUT_RECORDS', 'value':'3386'}
        self.counters.append(md)
        md={}
        md={'counter':'MAP_OUTPUT_RECORDS', 'value':'3288'}
        self.counters.append(md)
        md={}
        md={'counter':'PDC_EVENT_INVALID_CELLID', 'value':'98'}
        self.counters.append(md)
    
    def count(self):
        return len(self.counters)
    
    def object_at_columnrow(self, column, row):
        rowData = self.counters[row]
        return rowData[column]
    
    def string_atindex(self, index):
        return self.counters[index]


