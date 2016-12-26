#!/bin/bash
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com
source configuration

date="2016-11-24"

path_data="/home/nguyen/hiwi/lab_machine/"
path_in="/home/nguyen/hiwi/repository/results/obs/"
path_out="/home/nguyen/hiwi/repository/results/capacity/"


trigger_computeObs () {

	rm -R "$path_in"
	mkdir $path_in
	mkdir "$path_in"sc_cc
	mkdir "$path_in"sc_ci

	# Compute the average retTime
	./computeObs $path_data $path_in 1 $samples




}

trigger_capacity () {


	rm -R "$path_out"
	mkdir $path_out
	mkdir "$path_out"sc_cc
	mkdir "$path_out"sc_ci
	
	# Analyze the observed retTime
	./analysis $path_in $path_out 0 1
	./analysis $path_in $path_out 0 2
	./analysis $path_in $path_out 0 3
	./analysis $path_in $path_out 1 2
	./analysis $path_in $path_out 1 3
	./analysis $path_in $path_out 2 3

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


