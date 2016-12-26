# Plotting the list of coefficient of variance (Standard Deviation) of the given sample

 pathC = "./correct/correct"
 pathL = "./longest/longest"
 pathM = "./middle/middle"
 pathS = "./shortest/shortest"
 
 sd = "_sd_raw"

 set terminal png size 5000,7000 enhanced font "Helvetica,30"
 set output 'sd'.sample.'.png'
  

 set   autoscale                        
 unset log                             
 unset label                            
 set xtic auto                         
 set ytic auto                          
 #set title ""
 set xlabel "Iteration"
 set ylabel "time(ns)"
 #set xr [0:90]
 #set yr [0:90000]
 set yr [0:10000]
 #set ytics ("0" 0,"0.005" 0.005, "0.01" 0.01, "0.02" 0.02, "0.03" 0.03, "0.04" 0.04, "0.05" 0.05, "0.1" 0.1, "0.2" 0.2, "0.4" 0.4)

 set border 3 front ls 101 lc rgb '#000000' lw 3

 plot    pathC.sample.sd using 1:2 title 'Correct' with lines lc rgb '#ff0000' lw 3, \
         pathL.sample.sd using 1:2 title 'Longest' with lines lc rgb '#0000ff' lw 3, \
         pathM.sample.sd using 1:2 title 'Middle' with lines lc rgb '#228b22' lw 3, \
         pathS.sample.sd using 1:2 title 'Shortest' with lines lc rgb '#b8860b' lw 3, \
