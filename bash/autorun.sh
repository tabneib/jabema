#!/bin/bash
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com
start=$(date +%s.%N)


cwd=`pwd`
source `dirname $0`/configuration

# Encapsulate the Server
./encap

echo "------------------------------------------------"
echo -e "\tServer Compiler - Client Compiler"
echo "------------------------------------------------"

rm -R $path_to_tmp_output'*'

mkdir $path_to_tmp_output'correct'
mkdir $path_to_tmp_output'longest'
mkdir $path_to_tmp_output'middle'
mkdir $path_to_tmp_output'shortest'

#killall java
#./run server c &
$path_to_bash'run' client c 0 $samples

#killall java
#./run server c &
$path_to_bash'run' client c 1 $samples

#killall java
#./run server c &
$path_to_bash'run' client c 2 $samples

#killall java
#./run server c &
$path_to_bash'run' client c 3 $samples

echo "creating output folder..."
#rm -r ./output/sc_cc*
mkdir $path_to_tmp_output'sc_cc'
echo "moving files..."
cd $path_to_tmp_output
mv ./correct ./sc_cc/correct
mv ./longest ./sc_cc/longest
mv ./middle ./sc_cc/middle
mv ./shortest ./sc_cc/shortest
echo "output folder created."

cd $cwd

end=$(date +%s.%N)
runtime=$(python -c "print(${end} - ${start})")
echo "Experiment run in $runtime s"


