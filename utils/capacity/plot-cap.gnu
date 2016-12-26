

set size 1,1 
set terminal postscript enhanced eps size 4.0,4.0 color font 'Helvetica,36' linewidth 1 
set output '| ps2pdf -dEPSCrop - output.pdf' 
set key off
set bmargin 4 
set xrange [0:1.2]
set yrange [0:1.05]
set boxwidth 0.18
set format x ""
unset xtics
#set ytics rotate
set style line 1 lt 1 lc rgb "#7e2f8e" lw 4 
set style line 2 lt 1 lc rgb "#d95319" lw 4 
set style line 3 lt 1 lc rgb "#edb120" lw 4 
set style line 4 lt 1 lc rgb "#0072bd" lw 4 
set style line 5 lt 1 lc rgb "#77ac30" lw 4 
set style fill solid 0.25

set label 1 'B' at graph 0.167, -0.1 center
set label 2 'CC' at graph 0.334, -0.1 center
set label 3 'CA' at graph 0.501, -0.1 center
set label 4 'TB' at graph 0.668, -0.1 center
set label 5 'U' at graph 0.835, -0.1 center

plot 'cap.dat' using ($0+.2):1:2 with boxerrorbars ls 1 title col,\
	'' using ($0+.4):3:4 with boxerrorbars ls 2 title col,\
	'' using ($0+.6):5:6 with boxerrorbars ls 3 title col,\
	'' using ($0+.8):7:8 with boxerrorbars ls 4 title col,\
	'' using ($0+1.):9:10 with boxerrorbars ls 5 title col


