#!/bin/bash
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com

#path_in="./results/obs/2016-11-24/"
#path_out="./results/capacity/2016-11-24/"

source `dirname $0`/configuration

# Path to 
path_in=""
path_out=""

obs1=''
obs2=''

cwd=`pwd`

invalid () {
	echo -e "Invalid arguments!"
	echo -e "\t./analysis [path_in] [path_out] [0|1|2|3] [0|1|2|3]"
	exit
}

# Read arguments
#echo "path_in: "$1
#echo "path_out: "$2
if [ -z "$1" ]; then
	invalid
else
	path_in="$1"
fi

if [ -z "$2" ]; then
	invalid
else
	path_out="$2"
fi

case "$3" in

"0" )
	obs1="correct"
	;;

"1" ) 
	obs1="longest"
	;;

"2" )
	obs1="middle"
	;;

"3" )
	obs1="shortest"
	;;

* )
	invalid
	;;
esac

case "$4" in

"0" )
	obs2="correct"
	;;

"1" ) 
	obs2="longest"
	;;

"2" )
	obs2="middle"
	;;

"3" )
	obs2="shortest"
	;;

* )
	invalid
	;;
esac


#############################################################################


# Make directories 
# Copy data files & scripts
rm -R $path_to_results_tmp
mkdir $path_to_results_tmp
#mkdir $path_to_results_tmp"sc_cc"

#echo "copy path: "$path_in
cp -r "$path_in"*  $path_to_results_tmp
#cp  "$path_in"sc_cc/* ./results/tmp/sc_cc/
mkdir $path_to_results_tmp/report
#exit

cp $path_to_utils_capacity'*' $path_to_results_tmp'sc_cc/'

#----------------------->
#	SC-CC
#<-----------------------

 
#echo "current dir: "`pwd`
cd $path_to_results_tmp'sc_cc'

#echo "current dir: "`pwd`

# rename the data files
rm obs1.dat
rm obs2.dat
cp "$obs1".dat obs1.dat
cp "$obs2".dat obs2.dat


# Run cut to compute input for AE
python cut.py

# Plots for data points of timing measurements
cp obs1cut.dat cut1.dat
cp obs2cut.dat cut2.dat
gnuplot plot-points.gnu

sleep 2

# Plots for frequencies of occurence
cp obs1dist.dat dist1.dat
cp obs2dist.dat dist2.dat
gnuplot plot-freq.gnu
sleep 2


# Estimate capacity with AE
java -jar ae.jar -v 0 obs.dat > result.ae

# pack all results in the out folder
mkdir "$path_out"sc_cc/"$obs1"-"$obs2"
mv result.ae "$path_out"sc_cc/"$obs1"-"$obs2"/
mv points.png "$path_out"sc_cc/"$obs1"-"$obs2"/
mv freq.png "$path_out"sc_cc/"$obs1"-"$obs2"/

cd $cwd
rm -R $path_to_results_tmp
