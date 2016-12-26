
#set terminal postscript
set terminal png size 700,600
#set output '| ps2pdf - freq.pdf'
set output "freq.png"
#set title plotname
#set key bmargin left horizontal Right noreverse enhanced autotitles box linetype -1 linewidth 1.000
set key off
#set samples 800, 800
#set yrange [4500:5500]
plot 'dist1.dat' with boxes lc rgb 'red' lt 1 lw 2 ,\
     'dist2.dat' with boxes lc rgb 'blue' lt 1 lw 2

