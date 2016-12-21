# Copyright (c) Hoang-Duong Nguyen, Artem Starostin
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set size 1,1 
set terminal postscript enhanced eps size 4.0,4.0 color font 'Helvetica,36' linewidth 1 
set output '| ps2pdf -dEPSCrop - output.pdf' 
set key off
set bmargin 4 
set xrange [0:1.2]
set yrange [0:]
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

plot 'sp-cim.dat' using ($0+.2):1:2 with boxerrorbars ls 1 title col,\
	'' using ($0+.4):3:4 with boxerrorbars ls 2 title col,\
	'' using ($0+.6):5:6 with boxerrorbars ls 3 title col,\
	'' using ($0+.8):7:8 with boxerrorbars ls 4 title col,\
	'' using ($0+1.):9:10 with boxerrorbars ls 5 title col


