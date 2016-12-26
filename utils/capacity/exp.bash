#!/bin/bash



# Copy needed scripts
cp ../scripts/cut.py .
cp ../scripts/capacity.py .
cp ../scripts/tbl-cap.py .
cp ../scripts/tbl-reduct.py .
cp ../scripts/plot-points.gnu .
cp ../scripts/plot-freq.gnu .
cp ../scripts/plot-cap.gnu .
cp ../scripts/plot-reduct.gnu .


# this should be unnecessary in our case. We already have obs1 and obs2 !
python distinguish.py 1000


# This can be reused totally
python cut.py



# @NHD  We only need the baseline !!!!!!!!!!!!

# Plots for data points of timing measurements
cp obs1cut.dat cut1.dat
cp obs2cut.dat cut2.dat
gnuplot plot-points.gnu

sleep 2

mv output.pdf ./results/points.pdf
cp obs1cut.dat ./results/
cp obs2cut.dat ./results/

#cp obsCC1cut.dat cut1.dat
#cp obsCC2cut.dat cut2.dat
#gnuplot plot-points.gnu
#sleep 2
#mv output.pdf ./results/pointsCC.pdf
#cp obsCC1cut.dat ./results/
#cp obsCC2cut.dat ./results/

#cp obsCA1cut.dat cut1.dat
#cp obsCA2cut.dat cut2.dat
#gnuplot plot-points.gnu
#sleep 2
#mv output.pdf ./results/pointsCA.pdf
#cp obsCA1cut.dat ./results/
#cp obsCA2cut.dat ./results/

#cp obsTB1cut.dat cut1.dat
#cp obsTB2cut.dat cut2.dat
#gnuplot plot-points.gnu
#sleep 2
#mv output.pdf ./results/pointsTB.pdf
#cp obsTB1cut.dat ./results/
#cp obsTB2cut.dat ./results/

#cp obsU1cut.dat cut1.dat
#cp obsU2cut.dat cut2.dat
#gnuplot plot-points.gnu
#sleep 2
#mv output.pdf ./results/pointsU.pdf
#cp obsU1cut.dat ./results/
#cp obsU2cut.dat ./results/



# @NHD   We only need the baseline !!!!!!!!!!!!

# Plots for frequencies of occurence
cp obs1dist.dat dist1.dat
cp obs2dist.dat dist2.dat
gnuplot plot-freq.gnu
sleep 2
mv output.pdf ./results/freq.pdf
cp obs1dist.dat ./results/ 
cp obs2dist.dat ./results/

#cp obsCC1dist.dat dist1.dat
#cp obsCC2dist.dat dist2.dat
#gnuplot plot-freq.gnu
#sleep 2
#mv output.pdf ./results/freqCC.pdf
#cp obsCC1dist.dat ./results/ 
#cp obsCC2dist.dat ./results/

#cp obsCA1dist.dat dist1.dat
#cp obsCA2dist.dat dist2.dat
#gnuplot plot-freq.gnu
#sleep 2
#mv output.pdf ./results/freqCA.pdf
#cp obsCA1dist.dat ./results/ 
#cp obsCA2dist.dat ./results/

#cp obsTB1dist.dat dist1.dat
#cp obsTB2dist.dat dist2.dat
#gnuplot plot-freq.gnu
#sleep 2
#mv output.pdf ./results/freqTB.pdf
#cp obsTB1dist.dat ./results/ 
#cp obsTB2dist.dat ./results/

#cp obsU1dist.dat dist1.dat
#cp obsU2dist.dat dist2.dat
#gnuplot plot-freq.gnu
#sleep 2
#mv output.pdf ./results/freqU.pdf
#cp obsU1dist.dat ./results/ 
#cp obsU2dist.dat ./results/








# MOST IMPORTANT thing !!!!!!!!!!!
# @NHD  TODO: We only need the baseline !!!!!!!!!!




# Estimate capacity with AE
java -jar ae.jar -v 0 obs.dat > result.ae
java -jar ae.jar -v 0 obsCC.dat > resultCC.ae
java -jar ae.jar -v 0 obsCA.dat > resultCA.ae
java -jar ae.jar -v 0 obsTB.dat > resultTB.ae
java -jar ae.jar -v 0 obsU.dat > resultU.ae

cp result.ae ./results/
cp resultCC.ae ./results/
cp resultCA.ae ./results/
cp resultTB.ae ./results/
cp resultU.ae ./results/
sleep 2


python capacity.py
gnuplot plot-cap.gnu
sleep 2
mv output.pdf ./results/capacity.pdf

gnuplot plot-reduct.gnu
sleep 2
mv output.pdf ./results/reduction.pdf


# Merge PDFs
# pdfunite ./results/points.pdf ./results/freq.pdf ./results/pointsCC.pdf ./results/freqCC.pdf ./results/pointsCA.pdf ./results/freqCA.pdf ./results/pointsTB.pdf ./results/freqTB.pdf ./results/pointsU.pdf ./results/freqU.pdf ./results/report.pdf

# Clean
mv *.log ./results/
rm *.dat *.ae *.gnu
rm cut.py
rm capacity.py
rm tbl-cap.py
rm tbl-reduct.py



# Archive
cd ./results/
tar -zcvf raw.tar.gz raw/
rm -r ./raw/
cd ..


