import pandas
import matplotlib.pyplot as plt
import matplotlib
matplotlib.style.use('ggplot')
import sys
import Tkinter
import tkFileDialog

s = raw_input('Use online csv file? y/n : ')

if s.lower() == 'y':
    df = pandas.read_csv("https://raw.githubusercontent.com/ChristopheHunt/MSDA---Coursework" +
                "/master/Data%20602/Data%20602%20-%20Advanced%20Programming/" +
                "data/brainandbody.csv", index_col=False)

elif s.lower() == 'n':
    root = Tkinter.Tk()
    filename = tkFileDialog.askopenfilename(parent=root)
    df = pandas.read_csv(filename)
    root.withdraw()

else:
    print "input was not in y/n format"
    sys.exit("End")

df.columns = ['animal', 'body', 'brain']

def LinearRegression(dataframe):
    df = dataframe
    column_names = df.columns.values
    column_name = ', '.join(column_names)

    x_input = raw_input('Select X value from columns [%s]: ' % column_name)
    if not x_input in column_names:
        sys.exit("Not a column value...end")
    y_input = raw_input('Select Y value from columns [%s]: ' % column_name)
    if not y_input in column_names:
        sys.exit("Not a column value...end")

    x_value = x_input
    y_value = y_input

    df['X*Y'] = df[x_value] * df[y_value]
    df['X*X'] = df[x_value] * df[x_value]
    mean_x = float(sum(df[x_value])/ len(df[x_value]))
    mean_y = float(sum(df[y_value])/ len(df[y_value]))
    mean_xy = float(sum(df['X*Y'])/ len(df['X*Y']))
    mean_xx = float(sum(df['X*X'])/ len(df['X*X']))
    slope = float(((len(df.index)*mean_xy)-(mean_x*mean_y))/((len(df.index)*mean_xx) - (mean_x * mean_x)))
    intercept = float((mean_y - (slope*mean_x))/len(df.index))
    equation = ("Y = %sx + %s" % (round(slope, 2), round(intercept,2)))
    print "The equation for the line is : " + equation
    df['Linear Regression'] = ((slope*df[x_value])+ intercept)
    ax = df.plot(y = 'Linear Regression', x = x_value, label = equation)
    df.plot(kind = 'scatter',  y = y_value, x = x_value, ax = ax)
    plt.show()

LinearRegression(df)