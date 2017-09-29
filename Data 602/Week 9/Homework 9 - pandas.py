import pandas as pd
import numpy as np
from io import StringIO
import re
import Tkinter
import tkFileDialog

def create_dataframe(): 
    root = Tkinter.Tk()
    filename = tkFileDialog.askopenfilename(parent=root) 
    info = open(filename, 'r')
    root.withdraw()
    info = info.read().decode('utf-8')
    headers = ['host', 'date', 'request', 'HTTP_reply_code', 'bytes_in_the_reply']
    info = StringIO(info)
    return(pd.read_csv(info, sep="\s+", names=headers, header = None))

df = create_dataframe()

#Which hostname or IP address made the most requests?
x = pd.DataFrame(df['host'].value_counts())
print("Which hostname or IP address made the most requests?")
print(x.sort_values('host', ascending = False).head(1))


# In[3]:

#Which hostname or IP address received the most total bytes from the server?  How many bytes did it receive? 
x = pd.DataFrame(df.groupby('host')['bytes_in_the_reply'].sum())
print("Which hostname or IP address received the most total bytes from the server?  How many bytes did it receive?")
print(x.sort_values('bytes_in_the_reply',ascending=False).head(1))

#During what hour was the server the busiest in terms of requests?
#(You can do this by grouping each hour period e.g. 13:00 - 14:00.
# Then count the number of requests in each hour)
def create_data_frame_wDateIndex():
    from datetime import datetime
    df['date'] = df['date'].str.replace(r"[","")
    df['date'] = df['date'].str.replace(r"]","")
    df['date'] = pd.to_datetime('1995:08:' + df['date'], format = "%Y:%m:%d:%H:%M:%S")
    return(df.set_index(pd.DatetimeIndex(df['date'])))
    
df_time_indexed = create_data_frame_wDateIndex()
grouped = df_time_indexed.groupby(pd.TimeGrouper(freq='60Min'))
grouped = pd.DataFrame(grouped['request'].count())

print("#During what hour was the server the busiest in terms of requests?")
print(grouped.sort_values('request',ascending=False).head(1))


#Which .gif image was downloaded the most during the day?
df_grouped = df_time_indexed[df_time_indexed['request'].str.contains('gif')]
grouped = df_grouped.groupby([df_grouped.index.map(lambda t: t.minute), 'request'])
grouped = pd.DataFrame(grouped.count())
grouped = pd.DataFrame(grouped['host'])

print("Which .gif image was downloaded the most during the day?")
print(grouped.sort_values('host', ascending=False).head(1))

#What HTTP reply codes were sent other than 200?
reply_codes = df[df['HTTP_reply_code'] != 200]
reply_codes = pd.DataFrame(np.unique(reply_codes[['HTTP_reply_code']]))
print("What HTTP reply codes were sent other than 200?")
print(reply_codes[:8]) #TODO find out why text 'HTTP/1.0" appears

