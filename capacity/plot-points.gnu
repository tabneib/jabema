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

