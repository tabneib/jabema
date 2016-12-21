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

import numpy
import os

def readIntegers(path):
	with open(path) as f:
		return [int(x) for x in f]


# Reject outliers that are futher than 3 'stdev'
def rejectOutliers(data, m = 3.):
    d = numpy.abs(data - numpy.median(data))
    mdev = numpy.median(d)
    s = d/mdev if mdev else 0.
    return data[s<m]


def processOutputs(T):

	# @NHD  In our case only obs1.dat and obs2.dat are considered
	fnamePrefix = "obs" + T
	fname = fnamePrefix + ".dat"


	fname1 = fnamePrefix + "1.dat"
	fname2 = fnamePrefix + "2.dat"

	
	# Output file name

	fname1cut = fnamePrefix + "1cut.dat"
	fname2cut = fnamePrefix + "2cut.dat"

	fname1dist = fnamePrefix + "1dist.dat"
	fname2dist = fnamePrefix + "2dist.dat"



	# Read with time prescision 10^-18
	# trunscate the last digit
	#obs1 = numpy.array(map(lambda x: (x/10)*10, readIntegers(fname1)))
	#obs2 = numpy.array(map(lambda x: (x/10)*10, readIntegers(fname2)))

	obs1 = numpy.array(readIntegers(fname1))
	obs2 = numpy.array(readIntegers(fname2))

	# Reject outliers
	obs1 = rejectOutliers(obs1)
	obs2 = rejectOutliers(obs2)

	
	# Total samples of both inputs
	samples = len(obs1) + len(obs2)




	# Compute frequencies
	obs1bc = numpy.bincount(obs1)
	obs1freq = numpy.nonzero(obs1bc)[0]
	obs1dist = zip(obs1freq, obs1bc[obs1freq]) # contains pairs (value, # occurences)

	obs2bc = numpy.bincount(obs2)
	obs2freq = numpy.nonzero(obs2bc)[0]
	obs2dist = zip(obs2freq, obs2bc[obs2freq]) 




	# Compute size of output alphabet and variance and write them into log
	sizeY = len(obs1dist) + len(obs2dist)
	v = 2. * sizeY / samples
	
	open("exp.log", 'a').write("Samples = " + str(samples) + ", |Y| = " + str(sizeY) + ", v = " + str(v) + " for data in "+ fname + "\n")	



	#####  WRITE OUTPUT FILES #####


	# Write values with rejected outliers
	# CUT files are just obs files after removing outliers !!!
	open(fname1cut, 'w').write("\n".join(map(str, obs1)))
	open(fname2cut, 'w').write("\n".join(map(str, obs2)))

	#os.system("cp " + fname1cut + " ./results/raw/")
	#os.system("cp " + fname2cut + " ./results/raw/")





	#--------------->  Most important stuff !!
	
	# Write input for AE


	# files obs.dat  contains both obs1.dat and obs2.dat  (removed outliers)
	with open(fname, 'w') as f:
		f.write("\n".join(map(lambda x: "(1,"+str(x)+")", obs1)))
		f.write("\n")
		f.write("\n".join(map(lambda x: "(2,"+str(x)+")", obs2)))

	#os.system("cp " + fname + " ./results/raw/")





	# Write probability distributions
	with open(fname1dist, 'w') as f:
		for x, y in obs1dist:
			f.write("\n".join(["%i\t %i\n" % (x, y)]))

	with open(fname2dist, 'w') as f:
		for x, y in obs2dist:
			f.write("\n".join(["%i\t %i\n" % (x, y)]))

	#os.system("cp " + fname1dist + " ./results/raw/")
	#os.system("cp " + fname2dist + " ./results/raw/")


# Main show here

# @NHD  consider only baseline version !
processOutputs("")




