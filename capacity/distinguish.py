
import random
import os
import sys
import time


# This file is no more needed because we already have the obs1.dat and obs2.dat as output of the java SSDetector !


# Number of JVM invocations
# @NHD  This should be cleared out
#INVOCATIONS = int(sys.argv[1])

# Helpers
def readIntegers(path):
	with open(path) as f:
		return [int(x) for x in f]

def mean(data):
	return sum(data)/len(data)

# Timestamp
startTime = time.time()




# @NHD  this should be cleared out
# Clean Raw data folder and copy inputs there

os.system("rm -r results")
os.system("mkdir results")
os.system("mkdir results/raw")
#os.system("cp input1 ./results/raw/")
#os.system("cp input2 ./results/raw/")





# In our case we already have the data. 
# Adapt our naming convention to this one !!!!!

# Function that collects results/raw data for a distinguishing experiment
#def distinguishingExperiment(T):
	

	# There are 2 inputs => two outputs
	# @NHD  In our case we only need that baseline one !
	# =>  file format: output1-n.dat	output2-n.dat

#	fnameOutputPrefix = "output" + T
#	fnameOutput = fnameOutputPrefix + ".dat"
	

	# Observation file name
#	fnameObs1 = "obs" + T + "1.dat"
#	fnameObs2 = "obs" + T + "2.dat"
 
#	obs1 = []
#	obs2 = []

#	for i in range(INVOCATIONS):
		

		# This part should be removed
#		print("Transformation = " + T + ", experiment iteration " + str(i) + " of " + str(INVOCATIONS))

#		os.system("cp input1 input.dat")
#		os.system("java -jar -Djava.compiler=NONE kruskal.jar 0 1 " + T)







		# Read the output of the invocation
		# @NHD  This is a number !!!!
		# @NHD	fnameOutput  should be adapted to read our output retTime !

#		o = readIntegers(fnameOutput)
#		os.system("cp " + fnameOutput + "  ./results/raw/" + fnameOutputPrefix + "1-" + str(i) + ".dat")
#		m = mean(o)
#		obs1.append(m)
	

		
		# Delete !
#		os.system("cp input2 input.dat")
#		os.system("java -jar -Djava.compiler=NONE kruskal.jar 0 1 " + T)




		# Adapt the name !!!!!
#		o = readIntegers(fnameOutput)
#		os.system("cp " + fnameOutput + "  ./results/raw/" + fnameOutputPrefix + "2-" + str(i) + ".dat")
#		m = mean(o)
#		obs2.append(m)




	# OK, now we have the list of observed time for input 1 and input 2
	# And we write it out into the fnameObs1 and fnameObs2  .dat files

#	open(fnameObs1, 'w').write("\n".join(map(str, obs1)))
#	os.system("cp " + fnameObs1 + " ./results/raw/")

#	open(fnameObs2, 'w').write("\n".join(map(str, obs2)))
#	os.system("cp " + fnameObs2 + " ./results/raw/")


# Main show here

# @NHD  use only 1  ;)

#distinguishingExperiment("")
#distinguishingExperiment("CC")
#distinguishingExperiment("CA")
#distinguishingExperiment("TB")

# Unification coincides with cross-copying
#os.system("cp obsCC1.dat obsU1.dat")
#os.system("cp obsCC2.dat obsU2.dat")


# Timestamp
#s = "Eperiment with " + str(INVOCATIONS) + " invocations took " + str((time.time() - startTime)/60.) + " min\n"
#print(s)

#with open("exp.log",'a') as f:
#	f.write(s)


