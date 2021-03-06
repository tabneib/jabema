#!/bin/bash
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com

samples=1000

echo "------------------------------------------------"
echo -e "\tServer Compiler - Client Compiler"
echo "------------------------------------------------"

rm -R ./output/*

mkdir ./output/correct
mkdir ./output/longest
mkdir ./output/middle
mkdir ./output/shortest

#killall java
#./run server c &
./run client c 0 $samples

#killall java
#./run server c &
./run client c 1 $samples

#killall java
#./run server c &
./run client c 2 $samples

#killall java
#./run server c &
./run client c 3 $samples

echo "creating output folder..."
#rm -r ./output/sc_cc*
mkdir ./output/sc_cc
echo "moving files..."
mv ./output/correct ./output/sc_cc/correct
mv ./output/longest ./output/sc_cc/longest
mv ./output/middle ./output/sc_cc/middle
mv ./output/shortest ./output/sc_cc/shortest
echo "output folder created."



echo "------------------------------------------------"
echo -e "\tServer Compiler - Client Interpreter"
echo "------------------------------------------------"

mkdir ./output/correct
mkdir ./output/longest
mkdir ./output/middle
mkdir ./output/shortest


#killall java
#./run server c &
./run client i 0 $samples

#killall java
#./run server c &
./run client i 1 $samples

#killall java
#./run server c &
./run client i 2 $samples

#killall java
#./run server c &
./run client i 3 $samples
echo "creating output folder..."
#rm -r ./output/sc_ci
mkdir ./output/sc_ci
echo "moving files..."
mv ./output/correct ./output/sc_ci/correct
mv ./output/longest ./output/sc_ci/longest
mv ./output/middle ./output/sc_ci/middle
mv ./output/shortest ./output/sc_ci/shortest
echo "output folder created."
 
