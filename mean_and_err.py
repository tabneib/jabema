
#Confidence intervals for the mean running time

import math
import numpy as np
import ConfigParser
import sys
__author__ = "nhd"
zalpha = 1.960 # 95%


# Auxiliary function

def readFloats(path):
	with open(path) as f:
		return [float(x) for x in f]

def mean(data):
	return 1.0*sum(data)/len(data)


def stdev(data):
	m = mean(data)
	return math.sqrt(sum((x-m)**2.0 for x in data) / (len(data)-1))

# Reject outliers that are futher than 3 
def rejectOutliers(data, m = 3.):

    median = np.median(data)
	
    # Differences with median
    d = np.abs(data - np.median(data))

    # Median of the differences
    mdev = np.median(d)

    if (mdev == 0.):
	    result = data[data==median]
    else:
	    s = d/mdev
	    result = data[s<m]
   
    return result



tC = np.array(readFloats("correct.dat"))
tL = np.array(readFloats("longest.dat"))
tM = np.array(readFloats("middle.dat"))
tS = np.array(readFloats("shortest.dat"))

# Arrays for producing latex tables
xbars = []
xerrs = []


# Format header of the results file
with open("report_retTime.dat", 'w') as f:
	f.write("\"Correct\"\t Cerr\t \"Longest\"\t Lerr\t \"Middle\"\t Merr\t \"Shortest\"\t Serr\n")


# Correct
xbar = mean(tC)
sigma = stdev(tC)
xerr = zalpha*sigma/math.sqrt(len(tC))

xbars.append(xbar)
xerrs.append(xerr)

with open("report_retTime.dat", 'a') as f:
	f.write(str(xbar) + "\t" + str(xerr) + "\t")



# Longest
xbar = mean(tL)
sigma = stdev(tL)
xerr = zalpha*sigma/math.sqrt(len(tL))

xbars.append(xbar)
xerrs.append(xerr)

with open("report_retTime.dat", 'a') as f:
	f.write(str(xbar) + "\t" + str(xerr) + "\t")




# Middle
xbar = mean(tM)
sigma = stdev(tM)
xerr = zalpha*sigma/math.sqrt(len(tM))

xbars.append(xbar)
xerrs.append(xerr)

with open("report_retTime.dat", 'a') as f:
	f.write(str(xbar) + "\t" + str(xerr) + "\t")


# Shortest
xbar = mean(tS)
sigma = stdev(tS)
xerr = zalpha*sigma/math.sqrt(len(tS))

xbars.append(xbar)
xerrs.append(xerr)

with open("report_retTime.dat", 'a') as f:
	f.write(str(xbar) + "\t" + str(xerr) + "\t")


