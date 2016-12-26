#!/bin/bash
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com
source `dirname $0`/configuration



path_data=$path_to_archived_output
path_in=$path_to_results_obs
path_out=$path_to_results_cap

cwd = `pwd`

trigger_computeObs () {

	rm -R "$path_in"
	mkdir $path_in
	mkdir "$path_in"sc_cc
	#mkdir "$path_in"sc_ci

	# Compute the average retTime
	$path_to_bash"computeObs" $path_data $path_in 1 $samples

}

trigger_capacity () {


	rm -R "$path_out"
	mkdir $path_out
	mkdir "$path_out"sc_cc
	mkdir "$path_out"sc_ci
	
	# Analyze the observed retTime
	$path_to_bash"analysis" $path_in $path_out 0 1
	$path_to_bash"analysis" $path_in $path_out 0 2
	$path_to_bash"analysis" $path_in $path_out 0 3
	$path_to_bash"analysis" $path_in $path_out 1 2
	$path_to_bash"analysis" $path_in $path_out 1 3
	$path_to_bash"analysis" $path_in $path_out 2 3

}


invalid () {
	echo -e "Invalid arguments!"
	echo -e "\t./auto_analysis [all | capacity] [date]"
	exit
}

if [ -z "$2" ]; then
	invalid
	exit
else
	# build the ssdetector
	# Must be built here to handle the case we only want to analyze
	cd $path_to_utils_ssdetector
	ant
	
	#javac ./de.tud.mais.hiwi.client/src/client/*.java
	# prepare arguments
	date=$2
	path_data=$path_data$date"/"
	path_in=$path_in$date"/"
	path_out=$path_out$date"/"

	if [ "$1" = "all" ]; then
		trigger_computeObs
		trigger_capacity
	else
		if [ "$1" = "capacity" ]; then
			trigger_capacity
		fi
	fi
fi


