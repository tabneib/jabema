

import math

# Auxiliary function
def readFloats(path):
	with open(path) as f:
		return [round(float(x), 4) for x in f]

modExp 		= readFloats("../modExp/results/cap-xbars.dat")
modExpErr 	= readFloats("../modExp/results/cap-xerrs.dat")
shareVal	= readFloats("../shareValue/results/cap-xbars.dat")
shareValErr	= readFloats("../shareValue/results/cap-xerrs.dat")
kruskal 	= readFloats("../kruskal/results/cap-xbars.dat")
kruskalErr 	= readFloats("../kruskal/results/cap-xerrs.dat")
mulMod 		= readFloats("../mulMod16/results/cap-xbars.dat")
mulModErr 	= readFloats("../mulMod16/results/cap-xerrs.dat")

N = 5
titles = ["baseline (B)", "cross-copying (CC)", "cond. assign. (CA)", "trans. branching (TB)", "unification (U)"]

with open("../output/tbl-cap.tex", 'w') as f:
	f.write("\\begin{tabular}{lcccc}\n")
	f.write("\\hline\n")
	f.write("& \\modExp & \\shareValue & \\kruskal & \mulMod \\\\\n")
	f.write("\\hline\n")
	for i in range(N):
		f.write(titles[i])
		f.write(" & $" + str(modExp[i]) + "\\!\\pm\\!" + str(modExpErr[i]) + "$")
		f.write(" & $" + str(shareVal[i]) + "\\!\\pm\\!" + str(shareValErr[i]) + "$")
		f.write(" & $" + str(kruskal[i]) + "\\!\\pm\\!" + str(kruskalErr[i]) + "$")
		f.write(" & $" + str(mulMod[i]) + "\\!\\pm\\!" + str(mulModErr[i]) + "$\\\\\n")
	f.write("\\hline\n")
	f.write("\\end{tabular}\n")

