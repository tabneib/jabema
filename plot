#!/bin/bash
# author: nhd
source configuration

# Absolute paths are required


path_in="/home/nguyen/hiwi/lab_machine/"
path_out="/home/nguyen/hiwi/repository/results/plots/"
path_out_tmp="/home/nguyen/hiwi/repository/results/tmp"
mode=0
date=""



invalid () {
	echo -e "invalid arguments!\n"
	echo -e "\t./plot [date] [begin] [end]" 
}

start_plot (){
	
	#-------------------#
	# 	SC-CC
	#-------------------#
	mkdir "$path_out"/sc_cc
	

	# Copy all plotting script 
	cp ./plotter/plot.py "$path_out_tmp"/sc_cc
	cp ./plotter/*.gnu "$path_out_tmp"/sc_cc
	cd "$path_out_tmp"/sc_cc


	for (( c = $1 ; c <= $2 ; c++))
	do
		python plot.py $c			
		#mv retTime$c.png sc_cc_retTime-$c.png 
	done

	# Move all plots to the output directory
	mv *.png "$path_out"/sc_cc

	# hard-coded moving to repository directory
	#cd ../../..
	#rm -R "$path_out_tmp"/sc_cc
	
	#-------------------#
	# 	SC-CI
	#-------------------#

	#cp ./plotter/plot.py ./results/tmp/sc_ci
	#cp ./plotter/*.gnu ./results/tmp/sc_ci
	#cd results/tmp/sc_ci
	#for (( c = $1 ; c <= $2 ; c++))
	#do
#		python plot.py $c			
#		mv retTime$c.png sc_ci_retTime-$c.png 
#	done

#	mkdir -p ../plots/sc_ci
#	mv *.png ../plots/sc_ci
#
#	cd ../../..
#	rm ./results/tmp/sc_ci/plot.py
#	rm ./results/tmp/sc_ci/*.gnu 
	
}

echo "|-----------------------|"
echo -e "|\tPLOTTER\t\t|"
echo "|-----------------------|"
#compile the client source code 
javac ./de.tud.mais.hiwi.client/src/client/*.java

rm -r $path_out_tmp
mkdir $path_out_tmp
mkdir "$path_out_tmp"/sc_cc
mkdir "$path_out_tmp"/sc_cc/correct
mkdir "$path_out_tmp"/sc_cc/longest
mkdir "$path_out_tmp"/sc_cc/middle
mkdir "$path_out_tmp"/sc_cc/shortest
mkdir "$path_out_tmp"/sc_ci
mkdir "$path_out_tmp"/sc_ci/correct
mkdir "$path_out_tmp"/sc_ci/longest
mkdir "$path_out_tmp"/sc_ci/middle
mkdir "$path_out_tmp"/sc_ci/shortest



if [ -z $1 ]; then
	invalid
else
	date="$1"
	# Update the path to input and output directories
	path_in="$path_in"$date
	path_out="$path_out"$date

	# create the output directory
	rm -R $path_out
	mkdir $path_out
	
	if [ -z $2 ]; then
		invalid
		else
		if [ -z $3 ]; then
			# plot, begin = end
			java -cp ./de.tud.mais.hiwi.client/src client.SSDetector \
				$measurements $normalizationWindowSize $smoothingWindowSize $outlierFactor $sdWindowSize \
				$sdOutlierThreshold $steadyMeasurements $path_in $path_out_tmp $mode $2 $2
			# Now we already have the analyzed data, so start to plot
			start_plot $2 $3
		else
			# plot
			java -cp ./de.tud.mais.hiwi.client/src client.SSDetector \
				$measurements $normalizationWindowSize $smoothingWindowSize $outlierFactor $sdWindowSize \
				$sdOutlierThreshold $steadyMeasurements $path_in $path_out_tmp $mode $2 $3
			# Now we already have the analyzed data, so start to plot
			start_plot $2 $3
		fi
	fi
fi




