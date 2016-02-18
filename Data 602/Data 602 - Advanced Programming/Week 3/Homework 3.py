
import requests
import csv
import pandas 
import Tkinter
import tkFileDialog
import sys

#buying       v-high, high, med, low
#maint        v-high, high, med, low
#doors        2, 3, 4, 5-more
#persons      2, 4, more
#lug_boot     small, med, big
#safety       low, med, high
#class        unacc, acc, good, vgood
    
s = raw_input('Use online csv file? y/n : ')

if s.lower() == 'y': 
    df = pandas.read_csv("https://raw.githubusercontent.com/ChristopheHunt/MSDA" + 
                         "---Coursework/master/Data%20602/" + 
                         "Data%20602%20-%20Advanced%20Programming/" + 
                         "data/cars.data.csv", 
                         header=None, index_col=False)
elif s.lower() == 'n':
    root = Tkinter.Tk()
    filename = tkFileDialog.askopenfilename(parent=root) 
    df = pandas.read_csv(filename)
    root.withdraw()
    
else: 
    print "input was not in y/n format"
    sys.exit("End")

df.columns = [ 'buying', 'maint', 'doors','persons','lug_boot', 'safety', 'class']
df = df.apply(lambda df: df.astype('category')) 

safety_cat = ['low','med','high']
maint_cat = ['low','med','high','vhigh']
doors_cat = ['2','3','4','5more']


def columncheck(column, listvalues):
    check = list(set(pandas.unique(df[column].ravel())) - set(listvalues))
    if check != []:
       s = raw_input("%s column contains unexpected values:%s, this will be converted to NaN. Continue? y/n : " 
                     % (column, check))
       if s.lower() != 'y':
          sys.exit("End")

columncheck('safety', safety_cat)
columncheck('maint', maint_cat)
columncheck('doors', doors_cat)


def setcat(column, listvalues):
    df[column].cat.set_categories(listvalues, inplace = True)
    
setcat('safety', safety_cat)
setcat('maint', maint_cat)
setcat('doors', doors_cat)

#Print to the console the top 10 rows of the data sorted by 'safety' in descending order
results = df.sort_values(by = 'safety', ascending=[1])
print results.head(10)
raw_input("Press Enter to continue...  ")

#Print to the console the bottom 15 rows of the data sorted by 'maint' in ascending order
results = df.sort_values(by = 'maint', ascending = [0])
print results.tail(15)
raw_input("Press Enter to continue...  ")

#Print to the console all rows that are high or vhigh in fields 'buying', 'maint', and 'safety',
# sorted by 'doors' in ascending order.  Find these matches using regular expressions.
mask = df[['buying', 'maint','safety']].apply(lambda column: column.str.contains('vhigh|high', regex=True)).any(axis=1)
results = df[mask].sort_values(by = 'doors', ascending = [1])
print results
raw_input("Press Enter to continue...  ")

#Save to a file all rows (in any order) that are: 'buying': vhigh, 'maint': med, 'doors': 4, and 
#'persons': 4 or more.  The file path can be a hard-coded location (name it output.txt) or use a dialog box.  
results = df.query("buying == 'vhigh' and maint == 'med' and doors == '4' and (persons == '4' or persons == 'more')")
print results
savefile = tkFileDialog.asksaveasfile(mode='w', defaultextension=".csv")
results.to_csv(savefile, index = False)
savefile.close()
