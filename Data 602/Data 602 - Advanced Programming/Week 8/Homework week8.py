
# coding: utf-8

# In[1]:

import matplotlib
import matplotlib.pyplot as plt
from skimage.filters import threshold_otsu
import Tkinter
import tkFileDialog
import scipy
import numpy as np
import Image
import os
import pylab
import mahotas as mh

def image_threshold(): 
    root = Tkinter.Tk()
    filename = tkFileDialog.askopenfilename(parent=root) 
    image_name = os.path.basename(filename)
    img = Image.open(filename).convert('L')
    root.withdraw()

    arr = np.array(img)
    thresh = threshold_otsu(arr)
    binary = arr > thresh

    fig = plt.figure(figsize=(8, 2.5))
    ax1 = plt.subplot(1, 3, 1, adjustable='box-forced')
    ax2 = plt.subplot(1, 3, 2, sharex=ax1, sharey=ax1, adjustable='box-forced')

    ax1.imshow(arr, cmap=plt.cm.gray)
    ax1.set_title(("Original " + image_name))
    ax1.axis('off')

    ax2.imshow(binary, cmap=plt.cm.gray)
    ax2.set_title(("Thresholded " + image_name))
    ax2.axis('off')

    matplotlib.pyplot.show()


# In[2]:

image_threshold()


# In[5]:

def count_objects():

    root = Tkinter.Tk()
    filename = tkFileDialog.askopenfilename(parent=root) 
    image_name = os.path.basename(filename)
    img = scipy.misc.imread(filename, flatten = True)
    root.withdraw()
    imgf = scipy.ndimage.gaussian_filter(img, 4) 
    T = 100
    labeled, nr_objects = scipy.ndimage.label(imgf > T) 
    matplotlib.pyplot.imshow(labeled) 
    matplotlib.pyplot.show()
    print "Number of objects is %d " % nr_objects


# In[6]:

count_objects()


# In[33]:

def show_corners(corners,image,title=None):
    """Display a list of corners overlapping an image"""
    fig = plt.figure()
    plt.imshow(image)
    # Convert coordinates to x and y lists
    y_corner,x_corner = zip(*corners)
    plt.plot(x_corner,y_corner,'o') # Plot corners
    if title:
        plt.title(title)
    plt.xlim(0,image.shape[1])
    plt.ylim(image.shape[0],0) # Images use weird axes
    fig.set_size_inches(np.array(fig.get_size_inches()) * 1.5)
    plt.show()


# In[56]:

def find_center(): 
    from skimage.feature import corner_harris,corner_peaks
    
    root = Tkinter.Tk()
    filename = tkFileDialog.askopenfilename(parent=root) 
    image_name = os.path.basename(filename)
    img = scipy.misc.imread(filename, flatten = True)
    root.withdraw()
    imgf = scipy.ndimage.filters.gaussian_filter(img, 34)
    rmax = mh.regmax(imgf)
    matplotlib.pyplot.imshow(mh.overlay(img,rmax))
    matplotlib.pyplot.show()
    centers, nr_objects = mh.label(rmax)
    plt.imshow(centers, cmap='Greys', interpolation="nearest")
    matplotlib.pyplot.show()
 


# In[57]:

find_center()


# In[ ]:



