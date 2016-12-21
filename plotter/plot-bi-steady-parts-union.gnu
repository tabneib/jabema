# Plot results of all measurements of a sample (Not yet consider union state)

 pathC = "./correct/correct"
 pathL = "./longest/longest"
 pathM = "./middle/middle"
 pathS = "./shortest/shortest"


 union = "_union"

 set terminal png size 15000,7500 enhanced font "Helvetica,200"
 set output 'steadyPartsUnion'.sample.'.png'

 set   autoscale                        
 unset log                             
 unset label                            
 set xtic auto                         
 set ytic auto                          
 #set title ""
 set xlabel "Iteration"
 set ylabel "time(ns)"
 #set xr [0:90]
 #set yr [0:17000]
 set yr [0:]

 set border 5 front ls 101 lc rgb '#000000' lw 4

 plot    pathC.sample.union using 1:2 title 'Correct' with lines lc rgb '#a52a2a' lw 3, \
         pathL.sample.union using 1:2 title 'Longest' with lines lc rgb '#191970' lw 3, \
         pathM.sample.union using 1:2 title 'Middle' with lines lc rgb '#006400' lw 3, \
         pathS.sample.union using 1:2 title 'Shortest' with lines lc rgb '#a0522d' lw 3, \


