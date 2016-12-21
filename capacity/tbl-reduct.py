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

import math

# Auxiliary function
def readFloats(path):
	with open(path) as f:
		return [round(float(x), 2) for x in f]

modExp 		= readFloats("../modExp/results/reduct-xbars.dat")
shareVal	= readFloats("../shareValue/results/reduct-xbars.dat")
kruskal 	= readFloats("../kruskal/results/reduct-xbars.dat")
mulMod 		= readFloats("../mulMod16/results/reduct-xbars.dat")

N = 4
titles = ["cross-copying (CC)", "cond. assign. (CA)", "trans. branching (TB)", "unification (U)"]

with open("../output/tbl-reduct.tex", 'w') as f:
	f.write("\\begin{tabular}{lcccc}\n")
	f.write("\\hline\n")
	f.write("& \\modExp & \\shareValue & \\kruskal & \mulMod \\\\\n")
	f.write("\\hline\n")
	for i in range(N):
		f.write(titles[i])
		f.write(" & $" + str(modExp[i]) + "$")
		f.write(" & $" + str(shareVal[i]) + "$")
		f.write(" & $" + str(kruskal[i]) + "$")
		f.write(" & $" + str(mulMod[i]) + "$\\\\\n")
	f.write("\\hline\n")
	f.write("\\end{tabular}\n")

