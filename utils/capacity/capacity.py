
import math
import re
import os

# Extract capacity from the AE output
def extractCap(T):
	fname = "result" + T + ".ae"
	
	with open(fname) as f:
		o = [x.strip('\n') for x in f.readlines()]
	
	o.pop()	# last line is empty
	
	pattern = r"([+\-]?(?:(?:\d+)(?:\.\d*)?|(?:\.\d+)+)(?:[eE][+\-]?\d+)?)"

	cap = float(re.findall(pattern, o[0])[2])
	c1 = float(re.findall(pattern, o[len(o)-1])[0])
	c2 = float(re.findall(pattern, o[len(o)-1])[1])
	xerr = math.fabs(c2-c1)/2	
	
	return [cap, xerr]


# Main show here
res = extractCap("")
resCC = extractCap("CC")
resCA = extractCap("CA")
resTB = extractCap("TB")
resU = extractCap("U")



# Output capacity values for gnuplot
with open("cap.dat", 'w') as f:
	f.write("\"baseline\"\t Be\t \"cross-copying\"\t CCe\t \"conditional assignment\"\t CAe\t \"transactional branching\"\t TBe\t \"unification\"\t Ue\n")
	f.write(str(res[0]) + "\t" + str(res[1]) + "\t")
	f.write(str(resCC[0]) + "\t" + str(resCC[1]) + "\t")
	f.write(str(resCA[0]) + "\t" + str(resCA[1]) + "\t")
	f.write(str(resTB[0]) + "\t" + str(resTB[1]) + "\t")
	f.write(str(resU[0]) + "\t" + str(resU[1]) + "\n")

os.system("cp cap.dat ./results/")

# Output capacity values for latex
with open("cap-xbars.dat", 'w') as f:
	f.write(str(res[0]) + "\n")
	f.write(str(resCC[0]) + "\n")
	f.write(str(resCA[0]) + "\n")
	f.write(str(resTB[0]) + "\n")
	f.write(str(resU[0]) + "\n")

os.system("cp cap-xbars.dat ./results/")

with open("cap-xerrs.dat", 'w') as f:
	f.write(str(res[1]) + "\n")
	f.write(str(resCC[1]) + "\n")
	f.write(str(resCA[1]) + "\n")
	f.write(str(resTB[1]) + "\n")
	f.write(str(resU[1]) + "\n")

os.system("cp cap-xerrs.dat ./results/")



# Output capacity reduction values for gnuplot
b = res[0]
crCC = 100.0 * (b-resCC[0])/b 
crCA =  100.0 * (b-resCA[0])/b 
crTB =  100.0 * (b-resTB[0])/b
crU =  100.0 * (b-resU[0])/b

with open("reduct.dat", 'w') as f:
	f.write("\"cross-copying\"\t CCe\t \"conditional assignment\"\t CAe\t \"transactional branching\"\t TBe\t \"unification\"\t Ue\n")
	f.write(str(crCC) + "\t" + str(0) + "\t")
	f.write(str(crCA) + "\t" + str(0) + "\t")
	f.write(str(crTB) + "\t" + str(0) + "\t")
	f.write(str(crU) + "\t" + str(0) + "\t")

os.system("cp reduct.dat ./results/")

# Output capacity reduction values for latex

with open("reduct-xbars.dat", 'w') as f:
	f.write(str(crCC) + "\n")
	f.write(str(crCA) + "\n")
	f.write(str(crTB) + "\n")
	f.write(str(crU) + "\n")

os.system("cp reduct-xbars.dat ./results/")



