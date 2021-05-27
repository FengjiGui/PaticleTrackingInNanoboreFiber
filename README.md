# PaticleTrackingInNanoboreFiber
To conduct the data analysis, there are three steps:
(1) download the rawdata from Zenodo:  
(2) run "trackpy-NBF_RF" at first which is writen by Python, then you will get the Fig.1(d) in the manuscript,
    and a txt file including the positions data of the nanoparticle will be saved locally.
(3) run the Matlab programs "trajectory_MSD" and "segments_analysis" respectively, you can get the main results in Fig.2, Fig.3, Fig.4 and Fig.5 in the manuscript.
The Matlab code "simulation_100000_steps" can be used to produce the simulation curves in Fig.5(b).
Please note that the Matlab function "hindrance_factor_function" needs to be saved in the same file before you run the codes above. 
The Python codes require more than 32GB memory. Pyhthon 3.7 and Matlab R2016a can work with them.
