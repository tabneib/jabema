# Plot raw results of all measurements of a sample 

 pathC = "./correct/correct"
 pathL = "./longest/longest"
 pathM = "./middle/middle"
 pathS = "./shortest/shortest"

 raw = "_raw"

 set terminal png size 30000,10000 enhanced font "Helvetica,100"
 set output 'retTime'.sample.'_raw.png'

 set   autoscale                        
 unset log                             
 unset label                            
 set xtic auto                         
 set ytic auto                          
 #set title ""
 set xlabel "Iteration"
 set ylabel "time(ns)"
 #set xr [0:90]
 #set yr [0:37000]
 set yr [0:2500]

 set border 3 front ls 101 lc rgb '#000000' lw 4

 plot    pathC.sample.raw using 1:2 title 'Correct' with lines lc rgb '#a52a2a' lw 1, \
         pathL.sample.raw using 1:2 title 'Longest' with lines lc rgb '#191970' lw 1, \
         pathM.sample.raw using 1:2 title 'Middle' with lines lc rgb '#006400' lw 1, \
         pathS.sample.raw using 1:2 title 'Shortest' with lines lc rgb '#a0522d' lw 1, \

