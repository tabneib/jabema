package ssdetector;
import java.util.ArrayList;
import java.util.Collections;

/**
 * TODO comment em
 * @author Hoang-Duong Nguyen
 *
 *  
 */
public class SSDeterminer {
	
	/**
	 * Raw measured running times of all measurements of a sample
	 */
	private ArrayList<Long> data;
	
	/**
	 * Raw data that is normalized with window of size normalizationWinDowSize
	 */
	private ArrayList<Long> normalizedData;
	
	/**
	 * Normalized data that is one more time smoothed with a window of configurable size
	 * smoothingWinDowSize
	 */
	private ArrayList<Long> smoothedData;
	
	/**
	 * List of SD of all window
	 */
	private ArrayList<Double> sd;
	
	/**
	 * ArrayList that stores beginning and ending indices of the steady parts
	 */
	ArrayList<Integer> steadyParts;
	
	/**
	 * ArrayList that store the union of all steady parts
	 */
	ArrayList<Long> steadyPartUnion;
	
	/**
	 * ArrayList that stores the list of all SD of the union of all steady parts
	 */
	ArrayList<Double> unionSD;

	
	/**
	 * Outlier factor for the median-based outlier rejector
	 */
	private int outlierFactor;
	
	/**
	 * Threshold for detecting outliers of SD
	 */
	private double sdOutlierThreshold;			// around 1000
	
	/**
	 * Size of the window on raw data 
	 */
	protected int normalizationWindowSize;		
	
	/**
	 * Size of the window on normalized data
	 */
	private int smoothingWindowSize;
	
	/**
	 * Window size for computing the successive deviation
	 */
	private int SDWindowSize;			//  = 5  


	/**
	 * Constructor
	 * @param measurements
	 * 					The number of taken measurements
	 * @param normalizationWindowSize
	 * 					Window size for normalizing the 
	 * @param smoothingWindowSize
	 * 					Window size for smoothing the normalized data
	 * @param outlierFactor
	 * 					Outlier factor for the median-based outlier rejector
	 * @param sdWindowSize
	 * 					Window size for computing the successive deviation
	 * @param sdOutlierThreshold
	 * 					Threshold for detecting outliers of SD
	 */
	public SSDeterminer(int measurements, int normalizationWindowSize,
			int smoothingWindowSize, int outlierFactor, int sdWindowSize, 
			double sdOutlierThreshold){
		this.data = new ArrayList<Long>(measurements);
		this.normalizationWindowSize = normalizationWindowSize;
		this.smoothingWindowSize = smoothingWindowSize;
		this.sd = new ArrayList<Double>();
		this.outlierFactor = outlierFactor;
		this.SDWindowSize = sdWindowSize;
		this.sdOutlierThreshold = sdOutlierThreshold;
	}
	
	
	// ---------------------------------------------------------------------------------->
	//			Steady Point Detector
	// <----------------------------------------------------------------------------------
	
	/**
	 * Determine the steady point of the measured running time
	 * @return the overapproximation of the steady point 
	 */
	public int detectSteadyPoint() throws SSDeterminerError{
		
		int result;
		//-------------->
		// 	1st Filter
		//<--------------
		System.out.println("this.sd.size() = " + this.sd.size());
		this.steadyParts = filter(this.sd, this.smoothedData.size(), sdOutlierThreshold);
		
		System.out.println("steadyParts.size() = " + steadyParts.size());
		
		if (steadyParts.size() == 2){
			// If there is only 1 steady part (i.e. 2 end-points)
			// So it is the steady state, return the beginning point 
			steadyPartUnion = new ArrayList<Long>((smoothedData.subList(
						steadyParts.get(0), steadyParts.get(1) + 1)));	
			unionSD = computeSDlist(steadyPartUnion, SDWindowSize);	
			result = steadyParts.get(0);
		}
		else{
			// There are more than 2 steady parts (i.e. 4 or more end-points)
			// Generate the union of all steady parts
			ArrayList<Integer> startingIndices = new ArrayList<Integer>();
			// list of all starting points
			steadyPartUnion = new ArrayList<Long>();
			for(int i = 0; i <= steadyParts.size()-2; i+=2){
				// The first starting point is 0 !
				startingIndices.add(steadyPartUnion.size());
				steadyPartUnion.addAll(
					smoothedData.subList(steadyParts.get(i), steadyParts.get(i+1) + 1));
			}
			//-------------->
			// 	2nd Filter
			//<--------------
			unionSD = computeSDlist(steadyPartUnion, SDWindowSize);	
			
			ArrayList<Integer> filteredSteadyParts =
					filter(unionSD, this.smoothedData.size(), sdOutlierThreshold);
			
			// TODO debug
			//System.out.println("filteredSteadyParts size: " + filteredSteadyParts.size());
			
			// The steady point is the beginning point of the last part
			try {
				int steadyPoint = filteredSteadyParts.get(filteredSteadyParts.size() - 2);
				// Find and return the original position of the steadyPoint
				if(startingIndices.contains(steadyPoint))
					result = steadyParts.get(2*startingIndices.indexOf(steadyPoint));
				else{
					startingIndices.add(steadyPoint);
					Collections.sort(startingIndices);
					result = steadyParts.get(2*(startingIndices.indexOf(steadyPoint)-1));
				}
			} catch (ArrayIndexOutOfBoundsException e) {
				System.err.println("No steady part found after the 2nd Filter!");
				throw new SSDeterminerError();
			}
			
			
			
		}
		// plus 1 : against the case that steady and unsteady states interleave
		// plus 1 : for safety sake
		return (result+2)*smoothingWindowSize;
	}
	
	
	/**
	 * Filter to find the steady parts
	 * @param data
	 * 				given data
	 * @param originalDataSize
	 * 				The size of the original running time data
	 * @param factor
	 * 				factor for the filter to determine outliers
	 * @return
	 * 			The list of beginning and ending indices of the steady states
	 */
	private ArrayList<Integer> filter(
			ArrayList<Double> data, int originalDataSize, double factor){
		
		
		ArrayList<Integer> endPoints = new ArrayList<Integer>();
		boolean outlying = true;
		
		for (int i=0; i < data.size(); i++){
			if(data.get(i) >= factor){
				if(!outlying){
					outlying = true;
					// ending point
					// Just take a part of those steady part !
					endPoints.add(i);
				}
			}	
			else if(outlying){
				outlying = false;
				// beginning point
				endPoints.add(i);
			}
		}		
		// The last steady part doesn't have an ending point
		// so add the last element
		if(endPoints.size() % 2 == 1)
			endPoints.add(originalDataSize - 1);
		
		return endPoints;
	}
	
	

	// ---------------------------------------------------------------------------------->
	//			Normalizing and Smoothing Output
	// <----------------------------------------------------------------------------------
	
	
	/**
	 * Smooth the measured running time data
	 */
	public void smoothOutput(){

		// First normalize the output data
		// Take the mean of each normalization window without removing outliers
		int normalizedMeasurements = 
				(int) Math.floor(this.data.size() / normalizationWindowSize);		
		
		
		ArrayList<Long> tmpOutput = new ArrayList<Long>(normalizedMeasurements);
		ArrayList<Long> tmp = new ArrayList<Long>(normalizationWindowSize);
				
		for(int i = 0; i < normalizedMeasurements; i++){
			
			tmp.addAll(data.subList(i*normalizationWindowSize, 
					(i+1)*normalizationWindowSize));
			
			// Compute the mean of a window
			// TODO @NHD: Remove outliers in each normalized windows in order to make it
			// look better ;)
			//tmpOutput.add((long)computeMean(tmp));
			tmpOutput.add((long)computeMean(removeOutlier(tmp, outlierFactor)));
			tmp.clear();
		}
	
		normalizedData = new ArrayList<Long>(tmpOutput);
		
		
		
		
		// Smooth the output data - Level 1
		// Normalize the data, remove outliers in each normalization window in parallel
		tmpOutput.clear();
		tmp.clear();
				
		for(int i = 0; i < normalizedMeasurements; i++){
			
			tmp.addAll(data.subList(i*normalizationWindowSize, 
					(i+1)*normalizationWindowSize));
			
			// Remove outliers before computing the mean of a window
			tmpOutput.add((long)computeMean(removeOutlier(tmp, outlierFactor)));
			
			tmp.clear();
		}
	
		// Smooth = remove outliers in each smoothing window
		// Level 2
		if(smoothingWindowSize != 1){
			ArrayList<Long> smoothedData1 = new ArrayList<Long>(tmpOutput);
		
			// Second smoothing one more time with window size smoothingWindowSize	
			int smoothedMeasurements = 
					(int) Math.floor(smoothedData1.size() / smoothingWindowSize);
			
			
			tmpOutput = new ArrayList<Long>(smoothedMeasurements);
			tmp = new ArrayList<Long>(smoothingWindowSize);
					
			for(int i = 0; i < smoothedMeasurements; i++){
				
				tmp.addAll(smoothedData1.subList(i*smoothingWindowSize, 
						(i+1)*smoothingWindowSize));
				
				// Remove outliers before computing the mean of a window
				tmpOutput.add((long)computeMean(removeOutlier(tmp, outlierFactor)));
				
				tmp.clear();
			}
		}	
		this.smoothedData = new ArrayList<Long>(tmpOutput);	
		
		System.out.println("smoothedData.size() = " + smoothedData.size());
		// @NHD debug: OK until here ???????
	}
	
	
	
	// ---------------------------------------------------------------------------------->
	//			Auxiliary Methods
	// <----------------------------------------------------------------------------------
	
	/**
	 * Sliding through the given data and compute the list of the SD of all windows.
	 * @param data
	 * 				The given data
	 * @param smoothingWindow
	 * 				Size of the sliding window
	 */
	public void computeAllSD(ArrayList<Long> data, int smoothingWindow){	
		this.sd = computeSDlist(data, SDWindowSize);	
	}

	/**
	 * Sliding through the given data and compute the list of the SD of all windows.
	 * @param data
	 * 				The given data
	 * @param windowSize
	 * 				Size of the sliding window
	 * @return
	 */
	private ArrayList<Double> computeSDlist (ArrayList<Long> data, int windowSize){
		
		ArrayList<Double> sdList = new ArrayList<Double>();
		ArrayList<Long> window = new ArrayList<Long>();
		
		// Generate the first window
		
		System.out.println("data size: " + data.size());
		
		
		for(int i=0; i < windowSize; i++)
			window.add(data.get(i));
		
		// Start sliding window
		for(int i = windowSize; i <= data.size(); i++){
			sdList.add(computeSD(window));
			
			if(i == data.size())
				break;
			window.remove(0);
			window.add(data.get(i));
		}
		return sdList;
	}
	
	
	/**
	 * Removes all outliers from measured running time data
	 * @param window
	 * 			Size of the sliding window
	 * @param factor
	 * 			Factor for the Median-based outlier rejector
	 * @return
	 */
	private ArrayList<Long> removeOutlier(ArrayList<Long> window, double factor){
		
		
		long median = computeMedian(window);
		
		ArrayList<Long> d = new ArrayList<Long>(window.size());
		
		for (int i=0; i < window.size(); i++){
			d.add(Math.abs(window.get(i) - median));
		}
		
		long mdev = computeMedian(d);
		
		if(mdev == 0){
			for (int i=0; i < window.size(); i++){
				if(window.get(i) != median){
					window.remove(i);
					i--;
				}	
			}
		}
		else{
			// j: number of removed elements
			int j = 0;
			for (int i=0; i < window.size(); i++){
				if((d.get(i) / mdev) >= factor){
					window.remove(i - j);
					j++;
				}	
			}
		}
		return window;
	}
	
	/**
	 * Compute the median of the given data
	 * @param window
	 * 				The given Data
	 * @return The median of the given data
	 */
	private long computeMedian(ArrayList<Long> window){
		
		ArrayList<Long> tmpWindow = new ArrayList<Long>(window);
		//ArrayList<Long> tmpWindow = (ArrayList<Long>) window.clone();
		Collections.sort(tmpWindow);
		if (tmpWindow.size() % 2 == 1)
			return tmpWindow.get((tmpWindow.size()+1)/2-1);
		else{
		   	long lower = tmpWindow.get(tmpWindow.size()/2-1);
		   	long upper = tmpWindow.get(tmpWindow.size()/2);	 
		   	return (lower + upper) / 2;
		}	
	}

	
	/**
	 * Compute the mean of the given data
	 * @param window
	 * 				The given data
	 * @return The mean of the given data
	 */
	private<T> double computeMean(ArrayList<T> window){	
		double sum = 0;
		for(Object s : window)
			if (s.getClass().equals(Long.class))
				sum += (Long) s;
			else if (s.getClass().equals(Double.class))
				sum += (Double) s;
		return sum / window.size();
	}
		
	
	/**
	 * Compute the Successive Deviation of the given data
	 * @param window
	 * 			The given data
	 * @return	The successive deviation of the given data
	 */
	private double computeSD(ArrayList<Long> window){
		
		double sd = 0;
		for(int i=1; i < window.size(); i++){
			sd += Math.pow(window.get(i) - window.get(i-1), 2);
		}
		
		sd = sd / (window.size() - 1);
		
		return sd;
	}
	
	/**
	 * Compute the CoV of the given data
	 * @param deita
	 * 			The given data
	 * @param windowSize
	 * 			Size of the sliding window
	 * @param smoothingWindow
	 * 			Size of the smoothing window
	 * @param skip
	 * 			number of skipped indices
	 * @return
	 */
	public ArrayList<Double> computeCoV(ArrayList<Long> deita, 
			int windowSize, int smoothingWindow, int skip){
		
		ArrayList<Double> covList = new ArrayList<Double>();
		ArrayList<Long> window = new ArrayList<Long>();
		
		// Generate the first window
		for(int i=skip; i < (windowSize + skip); i++)
			window.add(deita.get(i));
		
		// Start sliding window
		ArrayList<Double> tmpCovWindow = new ArrayList<Double>(smoothingWindow) ;
		int counter = 0;
		for(int i = windowSize + skip; i <= deita.size(); i++){
			if(counter == smoothingWindow){
				counter = 0;
				sd.add(computeMean(tmpCovWindow));
				tmpCovWindow.clear();
				tmpCovWindow.add(computeSD(window)/computeMean(window));
			}
			else
				tmpCovWindow.add(computeSD(window)/computeMean(window));
			counter++;
			
			if(i == deita.size())
				break;
			window.remove(0);
			window.add(deita.get(i));
		}
		return covList;	
	}
	
	/**
	 * Add the given data to the ArrayList data
	 * @param data
	 * 				The given data
	 */
	public void add(long[] data){
		for(int i = 0; i < data.length; i++)
			this.data.add(data[i]);
	}

	/**
	 * Add the given data to the ArrayList data
	 * @param data
	 * 				The given data
	 */
	public void add(ArrayList<Long> data){
		this.data.addAll(data);
	}

	/**
	 * 
	 */
	public void reset(){
		try {
			this.data.clear();
			this.smoothedData.clear();
			this.normalizedData.clear();
			this.sd.clear();
			this.steadyParts.clear();
			this.steadyPartUnion.clear();
			this.unionSD.clear();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	// ---------------------------------------------------------------------------------->
	//			Getters
	// <----------------------------------------------------------------------------------
	

	public ArrayList<Long> getData(){
		return this.data;
	}
	
	public ArrayList<Long> getNormalizedData(){
		return this.normalizedData;
	}
	
	public ArrayList<Long> getSmoothedData(){
		return this.smoothedData;
	}

	public ArrayList<Double> getSD(){
		return this.sd;
	}
	
	// All elements in smoothed data that are not in any steady part will be 
	// replaced with -1
	public ArrayList<Long> getFilteredData(){
		ArrayList<Long> data = new ArrayList<Long>();
		int lastEndingPoint = 0;
		for(int i = 0; i <= steadyParts.size() - 2; i+=2 ){
			for(int j = lastEndingPoint; j < steadyParts.get(i); j++)
				data.add(j,new Long(-1));
			for(int j = steadyParts.get(i); j <= steadyParts.get(i+1); j++)
				data.add(j,smoothedData.get(j));
			lastEndingPoint = steadyParts.get(i+1) + 1;
		}
		// Debug: Fill the rest with -1
		for( int i = data.size(); i < smoothedData.size(); i++)
			data.add(i,new Long(-1));
		
		return data;
	}
	
	public ArrayList<Long> getSteadyPartUnion(){
		return this.steadyPartUnion;
	}

	public ArrayList<Double> getUnionSD(){
		return this.unionSD;
	}
	
}
