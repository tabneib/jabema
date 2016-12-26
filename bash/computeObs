#!/bin/bash
source `dirname $0`/configuration
# Compute the average retTime for each kind of input

# Absolute paths are required
#path_in="/home/nhd/hiwi/lab_machine/2016-11-20"
#path_out="/home/nhd/hiwi/repository/results/obs/2016-11-24/"

# ssdetector mode 1 => Detect the steady state
mode=1


echo "|-----------------------|"
echo -e "|\tCOMPUTE OBS\t|"
echo "|-----------------------|"
# We assume the directory hierachy is already created
#mkdir "$path_out"sc_cc
#mkdir "$path_out"sc_ci


# $1: path_in
# $2: path_out
# $3: begin iteration
# $4: end iteration
java -jar $path_to_utils_ssdetector'ssdetector.jar' \
			$measurements $normalizationWindowSize $smoothingWindowSize $outlierFactor $sdWindowSize \
			$sdOutlierThreshold $steadyMeasurements $1 $2 $mode $3 $4





