import numpy as np
import pandas as pd
from scipy.optimize import curve_fit

def func(x, a, b):
    return a * x + b

### Data set up from Chapter 3 SciPy text 
# Generating clean data
x = np.linspace(0, 10, 200)
y = func(x, 1, 5)
# Adding noise to the data
yn = y + 0.2 * np.random.normal(size=len(x))
### End of Chapter 3 data set up

X = list(x)
Y = list(yn)
df = pd.DataFrame(X)
df['Y'] = pd.Series(Y, index=df.index)
df.columns = ['X', 'Y']

def LinearRegression(dataframe):
    
    df = dataframe
    column_names = df.columns.values
    column_name = ', '.join(column_names)

    x_value = 'X'
    y_value = 'Y'

    mean_x = float(sum(df[x_value])/ len(df[x_value]))
    mean_y = float(sum(df[y_value])/ len(df[y_value]))

    df['X-mean_x'] = df[x_value] - mean_x
    df['Y-mean_y'] = df[y_value] - mean_y
    df['X-mean_x * Y-mean_y'] = df['X-mean_x'] * df['Y-mean_y']
    df['X-mean_x^2'] = df['X-mean_x']  * df['X-mean_x']
    slope = float(sum(df['X-mean_x * Y-mean_y'])/sum(df['X-mean_x^2']))
    intercept = float((mean_y - slope*mean_x))

    return (slope, intercept)

results = LinearRegression(df)
print "Least squares results : " + str(results)

def regression_numpy():
    
    fit, pcov = curve_fit(func, df['X'], df['Y'])
    return(fit)

results = regression_numpy()
print "Numpy curve fit results : " + str(results)

import timeit
    
number = 1000
setup = ("from __main__ import LinearRegression, func, df, regression_numpy")

regression = timeit.timeit("LinearRegression(df)", setup=setup, number = number)
numpy_regression = timeit.timeit("regression_numpy", setup=setup, number = number)
     
print "My least squares function time is : " + format(regression,'.8f') + " for " + str(number) + " loops"
print "Numpy curve_fit function time is : " + format(numpy_regression, '.8f') + " for " + str(number) + " loops"

