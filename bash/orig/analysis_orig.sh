#!/bin/bash
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com

#path_in="./results/obs/2016-11-24/"
#path_out="./results/capacity/2016-11-24/"

path_in=""
path_out=""

obs1=''
obs2=''


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
rm -R ./results/tmp
mkdir results/tmp
mkdir results/tmp/sc_cc
mkdir results/tmp/sc_ci

#echo "copy path: "$path_in
cp -r "$path_in"*  ./results/tmp/
#cp  "$path_in"sc_cc/* ./results/tmp/sc_cc/
#cp  "$path_in"sc_ci/* ./results/tmp/sc_ci/
mkdir ./results/tmp/report
#exit

cp ./capacity/* ./results/tmp/sc_cc/
cp ./capacity/* ./results/tmp/sc_ci/

#----------------------->
#	SC-CC
#<-----------------------

 
#echo "current dir: "`pwd`
cd results/tmp/sc_cc

#echo "current dir: "`pwd`

# rename the data files
rm obs1.dat
rm obs2.dat
#echo "current dir: "`pwd`
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

# pack all results in a folder

mkdir "$path_out"/sc_cc/"$obs1"-"$obs2"
mv result.ae "$path_out"/sc_cc/"$obs1"-"$obs2"/
mv points.png "$path_out"/sc_cc/"$obs1"-"$obs2"/
mv freq.png "$path_out"/sc_cc/"$obs1"-"$obs2"/

cd ..

#----------------------->
#	SC-CI
#<-----------------------

 
cd sc_ci

# rename the data files
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

# pack all results in a folder

mkdir "$path_out"/sc_ci/"$obs1"-"$obs2"
mv result.ae "$path_out"/sc_ci/"$obs1"-"$obs2"/
mv points.png "$path_out"/sc_ci/"$obs1"-"$obs2"/
mv freq.png "$path_out"/sc_ci/"$obs1"-"$obs2"/


cd ../../..

