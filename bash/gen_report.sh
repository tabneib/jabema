#!/bin/bash
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com

source `dirname $0`/configuration
cwd=`pwd`
report_dir=$path_to_reports$date

rm -R $report_dir
mkdir $report_dir
mkdir $report_dir/plots
mkdir $report_dir/plots/retTime
mkdir $report_dir/plots/retTime_raw
mkdir $report_dir/plots/other
mkdir $report_dir/obs
mkdir $report_dir/capacity

cp -R $path_to_results_cap$date/sc_cc/* $report_dir/capacity/


cp $path_to_results_plots$date/sc_cc/* $report_dir/plots/
mv $report_dir/plots/retTime[0-9].png $report_dir/plots/retTime
mv $report_dir/plots/retTime[0-9][0-9].png $report_dir/plots/retTime
mv $report_dir/plots/retTime*_raw.png $report_dir/plots/retTime_raw
mv $report_dir/plots/*.png $report_dir/plots/other

cp $path_to_bash'report_muster' $report_dir/report.txt
cp $path_to_bash'configuration' $report_dir/

cp $path_to_results_obs$date/sc_cc/* $report_dir/obs/
cp $path_to_bash'mean_and_err.py' $report_dir/obs/
cd $report_dir/obs/
python mean_and_err.py
rm mean_and_err.py
mv report_retTime.dat $report_dir/

cd $cwd


