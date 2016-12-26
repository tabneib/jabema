# Plot results of all measurements of a sample (Not yet consider steady state)

 pathC = "./correct/correct"
 pathL = "./longest/longest"
 pathM = "./middle/middle"
 pathS = "./shortest/shortest"

 steady = "_steady_parts"
 smoothed = "_smoothed"

 set terminal png size 15000,7500 enhanced font "Helvetica,100"
 set output 'steadyParts'.sample.'.png'

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
 #set yr [0:4000]

 filter(x)=(x>0?(x):(1/0))

 set border 3 front ls 101 lc rgb '#000000' lw 4

 plot    pathC.sample.smoothed using 1:2 title 'Correct' with lines lc rgb '#8b8989' lw 2, \
         pathL.sample.smoothed using 1:2 title 'Longest' with lines lc rgb '#8b8989' lw 2, \
         pathM.sample.smoothed using 1:2 title 'Middle' with lines lc rgb '#8b8989' lw 2, \
         pathS.sample.smoothed using 1:2 title 'Shortest' with lines lc rgb '#8b8989' lw 2, \
	 pathC.sample.steady u 1:(filter($2)) title 'Steady Parts - Correct' with lines lc rgb '#ff0000' lw 4, \
         pathL.sample.steady u 1:(filter($2)) title 'Steady Parts - Longest' with lines lc rgb '#0000ff' lw 4, \
         pathM.sample.steady u 1:(filter($2)) title 'Steady Parts - Middle' with lines lc rgb '#228b22' lw 4, \
         pathS.sample.steady u 1:(filter($2)) title 'Steady Parts - Shortest' with lines lc rgb '#b8860b' lw 4, \


