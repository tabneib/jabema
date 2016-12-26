# Plot results of all measurements of a sample (Not yet consider steady state)

 pathB = "results/raw/outputB"
 pathCC = "results/raw/outputCC"
 pathCA = "results/raw/outputCA"
 pathTB = "results/raw/outputTB"
 pathU = "results/raw/outputU"

 steady = "_steady.dat"
 smoothed = "_smoothed.dat"

 set terminal png size 15000,7500 enhanced font "Helvetica,100"
 set output 'runningTime'.sample.'.png'

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
 

 set border 3 front ls 101 lc rgb '#000000' lw 4

 plot    pathB.sample.smoothed using 1:2 title 'Baseline' with lines lc rgb '#8b8989' lw 1, \
         pathCC.sample.smoothed using 1:2 title 'Cross Copying' with lines lc rgb '#8b8989' lw 1, \
         pathCA.sample.smoothed using 1:2 title 'Conditional Assignment' with lines lc rgb '#8b8989' lw 1, \
         pathTB.sample.smoothed using 1:2 title 'Transactional Branching' with lines lc rgb '#8b8989' lw 1, \
         pathU.sample.smoothed using 1:2 title 'Unification' with lines lc rgb '#8b8989' lw 1, \
	 pathB.sample.steady using 1:2 title 'Steady State - Baseline' with lines lc rgb '#ff0000' lw 2, \
         pathCC.sample.steady using 1:2 title 'Steady State - Cross Copying' with lines lc rgb '#0000ff' lw 2, \
         pathCA.sample.steady using 1:2 title 'Steady State - Conditional Assignment' with lines lc rgb '#228b22' lw 2, \
         pathTB.sample.steady using 1:2 title 'Steady State - Transactional Branching' with lines lc rgb '#b8860b' lw 2, \
         pathU.sample.steady using 1:2 title 'Steady State - Unification' with lines lc rgb '#ba55d3' lw 2, \


