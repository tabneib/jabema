#!/bin/bash
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com
start=$(date +%s.%N)


cwd=`pwd`

source `dirname $0`/configuration

output_dir=$path_to_archived_output$date

# build the client and server
cd $path_to_impl'client'
ant
cd $path_to_impl'server'
ant


# Encapsulate the Server
$path_to_bash'encap'

echo "------------------------------------------------"
echo -e "\tServer Compiler - Client Compiler"
echo "------------------------------------------------"

######### prepare the folder ########
echo "[+] creating output folder..."
# temporal output folder
if [ -d $path_to_tmp_output ]; then
	rm -R $path_to_tmp_output
fi
mkdir $path_to_tmp_output
	

# archived output folder
if [ -d $output_dir ]; then
	# if the output folder already exists
	# then add the current time into the folder name
	# or better: add a number to the folder name	
	#output_dir=$output_dir'_'`date +'%H_%M'`
	#mkdir $output_dir
	i='1'
	output_dir_tmp=$output_dir'_'$i
	while [ -d $output_dir_tmp ]; do
		i=$[$i+1]
		output_dir_tmp=$output_dir'_'$i
	done
	output_dir=$output_dir_tmp
	mkdir $output_dir
else
	mkdir $output_dir
fi

output_dir=$output_dir'/sc_cc/'
mkdir $output_dir
#output_dir_correct=$output_dir'sc_cc/correct/'
#output_dir_longest=$output_dir'sc_cc/longest/'
#output_dir_middle=$output_dir'sc_cc/middle/'
#output_dir_shortest=$output_dir'sc_cc/shortest/'
#mkdir $output_dir_correct
#mkdir $output_dir_longest
#mkdir $output_dir_middle
#mkdir $output_dir_shortest

mkdir $path_to_tmp_output'correct/'
mkdir $path_to_tmp_output'longest/'
mkdir $path_to_tmp_output'middle/'
mkdir $path_to_tmp_output'shortest/'

#killall java
#./run server c &
$path_to_bash'run' client c 0 $samples
echo "[+] moving files..."
mv $path_to_tmp_output'correct' $output_dir
echo "[+] moving files: done"
#killall java
#./run server c &
$path_to_bash'run' client c 1 $samples
echo "[+] moving files..."
mv $path_to_tmp_output'longest' $output_dir
echo "[+] moving files: done"
#killall java
#./run server c &
$path_to_bash'run' client c 2 $samples
echo "[+] moving files..."
mv $path_to_tmp_output'middle' $output_dir
echo "[+] moving files: done"
#killall java
#./run server c &
$path_to_bash'run' client c 3 $samples
echo "[+] moving files..."
mv $path_to_tmp_output'shortest' $output_dir
echo "[+] moving files: done"



#rm -r ./output/sc_cc*
#mkdir $path_to_tmp_output'sc_cc'

#cd $path_to_tmp_output
#mv ./correct ./sc_cc/correct
#mv ./longest ./sc_cc/longest
#mv ./middle ./sc_cc/middle
#mv ./shortest ./sc_cc/shortest
#echo "output folder created."

cd $cwd
echo '[+] removing tmp_output..'
#rm $path_to_tmp_output
echo '[+] removing tmp_output: done'

end=$(date +%s.%N)
runtime=$(python -c "print(${end} - ${start})")
echo "Experiment run in $runtime s"


