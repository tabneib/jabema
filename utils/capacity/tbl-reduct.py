
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

