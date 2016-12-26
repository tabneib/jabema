# Plot results of all measurements of a sample and highlight the detected steady state part
# Argument: sample - The sample number to be plotted


 pathC = "./correct/correct"
 pathL = "./longest/longest"
 pathM = "./middle/middle"
 pathS = "./shortest/shortest"

 # steady = ".dat"
 steady = "_steady"
 normalized = "_normalized"

 set terminal png size 15000,7500 enhanced font "Helvetica,100"
 set output 'retTime'.sample.'.png'

 set   autoscale                        
 unset log                             
 unset label                            
 set xtic auto                         
 set ytic auto                          
 #set title ""
 set xlabel "Iteration"
 set ylabel "time(ns)"
 #set xr [0:90]
 #set yr [0:80000]
 set yr [0:2500]

 set border 3 front ls 101 lc rgb '#000000' lw 4

 plot    pathC.sample.normalized using 1:2 title 'Correct' with lines lc rgb '#a52a2a' lw 3, \
         pathL.sample.normalized using 1:2 title 'Longest' with lines lc rgb '#191970' lw 3, \
         pathM.sample.normalized using 1:2 title 'Middle' with lines lc rgb '#006400' lw 3, \
         pathS.sample.normalized using 1:2 title 'Shortest' with lines lc rgb '#a0522d' lw 3, \
         pathC.sample.steady using 1:2 title 'Steady State - Correct' with linespoint lc rgb '#ff0000' lw 6, \
         pathL.sample.steady using 1:2 title 'Steady State - Longest' with linespoint lc rgb '#0000ff' lw 6, \
         pathM.sample.steady using 1:2 title 'Steady State - Middle' with linespoint lc rgb '#228b22' lw 6, \
         pathS.sample.steady using 1:2 title 'Steady State - Shortest' with linespoint lc rgb '#b8860b' lw 6, \
         


