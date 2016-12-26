

set terminal png size 1000,600
set output "points.png"

#set terminal postscript
#set output '| ps2pdf - points.pdf'
#set title plotname
set key off
set format x ""
unset xtics
#set bmargin left horizontal Right noreverse enhanced autotitles box linetype -1 linewidth 1.000
#set samples 800, 800
#set yrange [4500:5500]
plot 'cut1.dat' with points linecolor rgb 'red' lw 2,\
     'cut2.dat' with points linecolor rgb 'blue' lw 2

