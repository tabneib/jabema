# Plot the normalized results of all measurements of a sample 


 pathC = "./correct/correct"
 pathL = "./longest/longest"
 pathM = "./middle/middle"
 pathS = "./shortest/shortest"

 flattened = "_normalized"

 set terminal png size 15000,7500 enhanced font "Helvetica,100"
 set output 'retTime'.sample.'_normalized.png'

 set   autoscale                        
 unset log                             
 unset label                            
 set xtic auto                         
 set ytic auto                          
 #set title ""
 set xlabel "Iteration"
 set ylabel "time(ns)"
 #set xr [0:90]
 set yr [0:37000]

 set border 3 front ls 101 lc rgb '#000000' lw 4

 plot    pathC.sample.flattened using 1:2 title 'Baseline' with lines lc rgb '#a52a2a' lw 2, \
         pathL.sample.flattened using 1:2 title 'Cross Copying' with lines lc rgb '#191970' lw 2, \
         pathM.sample.flattened using 1:2 title 'Conditional Assignment' with lines lc rgb '#006400' lw 2, \
         pathS.sample.flattened using 1:2 title 'Transactional Branching' with lines lc rgb '#a0522d' lw 2, \



