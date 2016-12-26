#!/usr/bin/env python
import random
import os
import sys
import time
import datetime
import ConfigParser
import numpy

PLOT_SAMPLE = sys.argv[1]

def plotRawRunningTime( sample ):

	cmd = '''gnuplot -e 'sample="''' + sample + '''"' plot-bi-raw.gnu'''
	os.system(cmd)

	return

# Plot the smoothed running time with highlighted steady state part
def plotRunningTime( sample ):

	cmd = '''gnuplot -e 'sample="''' + sample + '''"' plot-bi.gnu'''
	os.system(cmd)

	return


def plotSmoothedRunningTime( sample ):

	cmd = '''gnuplot -e 'sample="''' + sample + '''"' plot-bi-smoothed.gnu'''
	os.system(cmd)

	return


def plotSD( sample ):
	
	cmd = '''gnuplot -e 'sample="''' + sample + '''"' plot-sd.gnu'''
	os.system(cmd)

	return


def plotSteadyState( sample ):
	
	cmd = '''gnuplot -e 'sample="''' + sample + '''"' plot-bi-steady.gnu'''
	os.system(cmd)

	return


def plotSteadyParts( sample ):

	cmd = '''gnuplot -e 'sample="''' + sample + '''"' plot-bi-steady-parts.gnu'''
	os.system(cmd)
	return


def plotSteadyUnion( sample ):

	cmd = '''gnuplot -e 'sample="''' + sample + '''"' plot-bi-steady-parts-union.gnu'''
	os.system(cmd)

	return


def plotSteadyUnionSD( sample ):

	cmd = '''gnuplot -e 'sample="''' + sample + '''"' plot-bi-steady-parts-union-sd.gnu'''
	os.system(cmd)

	return

plotRunningTime(str(PLOT_SAMPLE))
plotRawRunningTime(str(PLOT_SAMPLE))
plotSmoothedRunningTime(str(PLOT_SAMPLE))
plotSD(str(PLOT_SAMPLE))
#plotSteadyState(str(PLOT_SAMPLE))
plotSteadyParts(str(PLOT_SAMPLE))
plotSteadyUnion(str(PLOT_SAMPLE))
plotSteadyUnionSD(str(PLOT_SAMPLE))
	

