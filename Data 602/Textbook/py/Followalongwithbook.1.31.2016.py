__author__ = 'Christophe'
import odbchelper
import sys

params = {"server":"mpligrim","database":"master","uid":"sa","pwd":"secret"}
print odbchelper.buildConnectionString(params)
print odbchelper.buildConnectionString.__doc__

print sys.path
print sys