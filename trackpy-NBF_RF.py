# -*- coding: utf-8 -*-
"""
Created on Thu Apr  8 16:18:47 2021

@author: guifengji
"""

# more functions please see the webpage http://soft-matter.github.io/trackpy/v0.4.2/tutorial/walkthrough.html
from __future__ import division, unicode_literals, print_function  # for compatibility with Python 2 and 3

import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab

mpl.rc('figure',  figsize=(10, 5))
mpl.rc('image', cmap='gray')

import numpy as np
import pandas as pd
from pandas import DataFrame, Series  # for convenience
# from hurst import compute_Hc, random_walk
# import pims
import trackpy as tp
from scipy.stats import norm
# @pims.pipeline
def gray(image):
    return image[:, :]  

from skimage import io
import time

# In[read image]
# frames = gray(pims.open('D:/frames/gold-2020-8-6/rcd5-0,2ms/*.tif')) # read the image from the path
data_file_name = r"\\mars\usr\FA2_Faseroptik\FAG24_Faseropt_Systeme\Foerster\Data\Fengji\08.04.2021\frames stack.tif"

read_start = time.time()

frames = io.imread(data_file_name)

read_end = time.time()

read_time = read_end - read_start

print("time to read data in: ", read_time)

#plt.imshow(frames[0]);

# In[evaluate images]

#f = tp.locate(frames[0], 11, minmass=500)
#tp.annotate(f, frames[0]);
# test_frames = frames[:2000,:,:].copy()

loc_start = time.time()

tp.quiet()
f = tp.batch(frames, 17, minmass=10000, processes = "auto"); # locate the particle in every
loc_end = time.time()

loc_time = loc_end - loc_start
print("time to localize the data: ", loc_time)

t = tp.link(f, 25, memory=25) # recognize the trajectory of the particle
link_end = time.time()

link_time = link_end - loc_end
print("time to link the data: ", link_time)


tm = t[t['particle'] ==0] # choose the data of particle No.0
plt.plot(tm['frame'],tm['x']-np.mean(tm['x'])) # plot the trajectory of the particle in the transmision direction of the fiber  
plt.xlabel('frames')
plt.ylabel('z-positions(pixel)')
#np.savetxt(r'x:\xxx\data.txt',f)  #save the data list as txt file waiting for further process 
