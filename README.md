# PaticleTrackingInNanoboreFiber
To conduct the data analysis, there are three steps:
(1) download the rawdata from Zenodo: https://zenodo.org/record/4835794  
(2) enter your path of the rawdata in "trackpy-NBF_RF" which is writen by Python and run it, then you will get the Fig.1(d) in the manuscript,
    and a txt file including the positions data of the nanoparticle will be saved locally(enter your path here).
(3) run the Matlab programs "trajectory_MSD" and "segments_analysis" for the txt file obtained from step (1), 
    then you can get the main results in Fig.2, Fig.3, Fig.4 and Fig.5 of the manuscript.
The Matlab code "simulation_100000_steps" can be used to produce the simulation curves in Fig.5(b).
Please note that the Matlab function "hindrance_factor_function" needs to be saved in the same file before you run the codes above. 
The Python codes require at least 32GB memory for this data. Pyhthon 3.7 and Matlab R2016a can work with them.
