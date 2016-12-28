#!/bin/bash/
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com

# <-------------------------------- 
# 	Experiment parameters
# --------------------------------> 

init_port=1111
samples=1

# For auto_analysis
#date="2016-12-22"
date=`date +%Y-%m-%d`


# <-------------------------------- 
# 	SSDetector parameters
# --------------------------------> 

#measurements=200000
measurements=1000
normalizationWindowSize=40
smoothingWindowSize=100
outlierFactor=2
sdWindowSize=5
sdOutlierThreshold=500
# should be at least normalizationWindowSize x smoothingWindowSize x 2
steadyMeasurements=10000



# <-------------------------------- 
# 	Absolute paths
# --------------------------------> 

# major paths
path_to_project_code="/home/"$USER"/svn/nguyen-hiwi-timing/code/mac-timing-vulnerability/"
path_to_archived_output="/home/"$USER"/hiwi/lab_machine/"

# path to report folder
path_to_reports=$path_to_project_code'archive/reports/'
# paths to computed results
path_to_results_obs=$path_to_project_code"archive/results/obs/"
path_to_results_cap=$path_to_project_code"archive/results/capacity/"
path_to_results_plots=$path_to_project_code"archive/results/plots/"
path_to_results_tmp=$path_to_project_code"archive/results/tmp/"

# paths to utilities
path_to_utils_plotter=$path_to_project_code"utils/plotter/"
path_to_utils_capacity=$path_to_project_code"utils/capacity/"
path_to_utils_ssdetector=$path_to_project_code"utils/SSDetector/"
path_to_utils_encapsulation=$path_to_project_code"utils/Encapsulation/"

path_to_tmp_output=$path_to_project_code"tmp_output/"

path_to_bash=$path_to_project_code"bash/"

path_to_impl=$path_to_project_code"impl/"

path_to_build=$path_to_project_code"build/"


