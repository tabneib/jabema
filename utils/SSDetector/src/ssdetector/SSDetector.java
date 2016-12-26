package ssdetector;
import java.util.ArrayList;
import java.util.Collections;

/**
 * TODO comment me
 * @author Hoang-Duong Nguyen
 *
 *  
 */
public class SSDetector {

	
	private static int measurements = 100000;
	private static int normalizationWindowSize = 50;
	private static int smoothingWindowSize = 10;
	private static int outlierFactor = 3;
	private static int sdWindowSize = 5;
	private static int sdOutlierThreshold = 1000;
	private static int steadyMeasurements = 10;
	private static String path_in = "";
	private static String path_out = "";
	private static int mode = 0;
	
	/**
	 * begin and end iterations for plotter
	 */
	private static int begin;
	private static int end;
	private static ArrayList<Long> data;
	private static String files[] = { "correct", "longest", "middle", "shortest" };
	private static Utils u = new Utils();
	private static int sPoint;
	private static ArrayList<Integer> failedIterations = new ArrayList<Integer>();
	
	
	private static ArrayList<Long> ccCorrect;
	private static ArrayList<Long> ccLongest;
	private static ArrayList<Long> ccMiddle;
	private static ArrayList<Long> ccShortest;
	private static ArrayList<Long> ciCorrect;
	private static ArrayList<Long> ciLongest;
	private static ArrayList<Long> ciMiddle;
	private static ArrayList<Long> ciShortest;
	
	
	/**
	 * TODO comment em
	 * @param args
	 * 0	measurements
	 * 1	normalizationWindowSize
	 * 2	smoothingWindowSize
	 * 3	outlierFactor
	 * 4	sdWindowSize
	 * 5	sdOutlierThreshold
	 * 6	steadyMeasurements
	 * 7	path to input folder
	 * 8	path to output folder
	 * 9	mode
	 * 10	begin
	 * 11	end
	 * 
	 */
	public static void main(String[] args){
		
		measurements = Integer.parseInt(args[0]);
		normalizationWindowSize = Integer.parseInt(args[1]);
		smoothingWindowSize = Integer.parseInt(args[2]);
		outlierFactor = Integer.parseInt(args[3]);
		sdWindowSize = Integer.parseInt(args[4]);
		sdOutlierThreshold = Integer.parseInt(args[5]);
		steadyMeasurements = Integer.parseInt(args[6]);
		path_in = args[7];
		path_out = args[8];
		mode = Integer.parseInt(args[9]);
		begin = Integer.parseInt(args[10]);
		end = Integer.parseInt(args[11]);
		
		
		SSDeterminer ssd = new SSDeterminer(measurements, normalizationWindowSize,
				smoothingWindowSize, outlierFactor, sdWindowSize, sdOutlierThreshold);
		switch (mode) {
		case 0:
			// Plotter
			for (int i = begin; i <= end; i++) {
				
				// SC-CC
				System.out.println("SC-CC | correct | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_cc/correct/correct" + i);
				ssd.reset();
				ssd.add(data);
				ssd.smoothOutput();
				ssd.computeAllSD(ssd.getSmoothedData(), sdWindowSize);
				try {
					sPoint = ssd.detectSteadyPoint();
					writeOutput(ssd, path_out + "/sc_cc/correct/correct" + i, sPoint);
				} catch (SSDeterminerError e) {
					System.err.println("Cannot determine the steady point!");
					failedIterations.add(i);
				}
				
				System.out.println("SC-CC | longest | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_cc/longest/longest" + i);
				ssd.reset();
				ssd.add(data);
				ssd.smoothOutput();
				ssd.computeAllSD(ssd.getSmoothedData(), sdWindowSize);
				try {
					sPoint = ssd.detectSteadyPoint();
					writeOutput(ssd, path_out + "/sc_cc/longest/longest" + i, sPoint);
				} catch (SSDeterminerError e) {
					System.err.println("Cannot determine the steady point!");
					failedIterations.add(i);
				}
				
				
				System.out.println("SC-CC | middle | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_cc/middle/middle" + i);
				ssd.reset();
				ssd.add(data);
				ssd.smoothOutput();
				ssd.computeAllSD(ssd.getSmoothedData(), sdWindowSize);
				try {
					sPoint = ssd.detectSteadyPoint();
					writeOutput(ssd, path_out + "/sc_cc/middle/middle" + i, sPoint);
				} catch (SSDeterminerError e) {
					System.err.println("Cannot determine the steady point!");
					failedIterations.add(i);
				}
				
				System.out.println("SC-CC | shortest | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_cc/shortest/shortest" + i);
				ssd.reset();
				ssd.add(data);
				ssd.smoothOutput();
				ssd.computeAllSD(ssd.getSmoothedData(), sdWindowSize);
				try {
					sPoint = ssd.detectSteadyPoint();
					writeOutput(ssd, path_out + "/sc_cc/shortest/shortest" + i, sPoint);
				} catch (SSDeterminerError e) {
					System.err.println("Cannot determine the steady point!");
					failedIterations.add(i);
				}
				
				
				
				
				/** SC-CI 
				System.out.println("SC-CI | correct | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_ci/correct/correct" + i);
				ssd.reset();
				ssd.add(data);
				ssd.smoothOutput();
				ssd.computeAllSD(ssd.getSmoothedData(), sdWindowSize);
				try {
					sPoint = ssd.detectSteadyPoint();
					writeOutput(ssd, path_out + "/sc_ci/correct/correct" + i, sPoint);
				} catch (SSDeterminerError e) {
					System.err.println("Cannot determine the steady point!");
					failedIterations.add(i);
				}
				
				System.out.println("SC-CI | longest | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_ci/longest/longest" + i);
				ssd.reset();
				ssd.add(data);
				ssd.smoothOutput();
				ssd.computeAllSD(ssd.getSmoothedData(), sdWindowSize);
				try {
					sPoint = ssd.detectSteadyPoint();
					writeOutput(ssd, path_out + "/sc_ci/longest/longest" + i, sPoint);
				} catch (SSDeterminerError e) {
					System.err.println("Cannot determine the steady point!");
					failedIterations.add(i);
				}
				
				System.out.println("SC-CI | middle | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_ci/middle/middle" + i);
				ssd.reset();
				ssd.add(data);
				ssd.smoothOutput();
				ssd.computeAllSD(ssd.getSmoothedData(), sdWindowSize);
				try {
					sPoint = ssd.detectSteadyPoint();
					writeOutput(ssd, path_out + "/sc_ci/middle/middle" + i, sPoint);
				} catch (SSDeterminerError e) {
					System.err.println("Cannot determine the steady point!");
					failedIterations.add(i);
				}
				
				System.out.println("SC-CI | shortest | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_ci/shortest/shortest" + i);
				ssd.reset();
				ssd.add(data);
				ssd.smoothOutput();
				ssd.computeAllSD(ssd.getSmoothedData(), sdWindowSize);
				try {
					sPoint = ssd.detectSteadyPoint();
					writeOutput(ssd, path_out + "/sc_ci/shortest/shortest" + i, sPoint);
				} catch (SSDeterminerError e) {
					System.err.println("Cannot determine the steady point!");
					failedIterations.add(i);
				}

				**/
			}
			break;

		//----------------------->
		//	MAIN MODE
		//<-----------------------
			
			
			
		case 1:
			ccCorrect 	= new ArrayList<Long>();
			ccLongest 	= new ArrayList<Long>();
			ccMiddle 	= new ArrayList<Long>();
			ccShortest 	= new ArrayList<Long>();
			
			//System.out.println("foooooooooooooooooooooooooooooooooooooooooooooooooooooooooOO");
			
			long tmp;
			
			for (int i = begin; i <= end; i++) {
				
				// SC-CC
				System.out.println("SC-CC | correct | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_cc/correct/correct" + i);
				tmp = computeRetTime(data, ssd);
				if (tmp != -1)
					ccCorrect.add(tmp);
				
				System.out.println("SC-CC | longest | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_cc/longest/longest" + i);
				tmp = computeRetTime(data, ssd);
				if (tmp != -1)
					ccLongest.add(tmp);
				
				System.out.println("SC-CC | middle | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_cc/middle/middle" + i);
				tmp = computeRetTime(data, ssd);
				if (tmp != -1)
					ccMiddle.add(tmp);
				
				System.out.println("SC-CC | shortest | Iteration: " + i);
				data = u.readDataFile(path_in + "/sc_cc/shortest/shortest" + i);
				tmp = computeRetTime(data, ssd);
				if (tmp != -1)
					ccShortest.add(tmp);
				
				
				
			}	
			

			u.writeNormalOutputFile(
					path_out + "/sc_cc/correct.dat", ccCorrect, 0, ccCorrect.size()-1, 0);
			u.writeNormalOutputFile(
					path_out + "/sc_cc/longest.dat", ccLongest, 0, ccLongest.size()-1, 0);
			u.writeNormalOutputFile(
					path_out + "/sc_cc/middle.dat", ccMiddle, 0, ccMiddle.size()-1, 0);
			u.writeNormalOutputFile(
					path_out + "/sc_cc/shortest.dat", ccShortest, 0, ccShortest.size()-1, 0);
	
			
			break;
			
		default:
			break;
		}
	}
	
	
	
	/**
	 * 
	 * @param data
	 * @param ssd
	 * @return
	 */
	private static long computeRetTime(ArrayList<Long> data, SSDeterminer ssd){
		ssd.reset();
		ssd.add(data);
		ssd.smoothOutput();
		ssd.computeAllSD(ssd.getSmoothedData(), sdWindowSize);
		
		try {
			sPoint = ssd.detectSteadyPoint();

			System.out.println("~~+~~+~~+~~+~~+~~+~~+~~+~~+~~+~~+~~+~~+~~+~~Steady Point: "
									+ sPoint + "\n");
			ArrayList<Long> steadyData = new ArrayList<Long>(ssd.getData().subList
					(normalizationWindowSize*sPoint, 
					normalizationWindowSize*sPoint + steadyMeasurements)); 
			return u.average(u.removeOutlier(steadyData, outlierFactor));
			
			//writeOutput(ssd, path_out + "/sc_cc/correct/correct" + i, sPoint);
		} catch (Exception e) {
			System.err.println("Cannot determine the steady data");
			return -1;
			//failedIterations.add(i);
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * Legacy code
	 * @param ssd
	 * @param fileName
	 * @param sPoint
	 */
	private static void writeOutput(SSDeterminer ssd, String fileName, int sPoint){
		
		System.out.println("~~+~~+~~+~~+~~+~~+~~+~~+~~+~~+~~+~~+~~+~~+~~Steady Point: "
								+ sPoint + "\n");
		
		u.writeOutputFile(fileName + "_raw", ssd.getData(), 
				0, ssd.getData().size()-1, 0);
		
		// Save smoothed (flattened) data
		u.writeOutputFile(fileName + "_smoothed", 
				ssd.getSmoothedData(), 0, 
				ssd.getSmoothedData().size()-1, 0);	
			
		// Save normalized data
		u.writeOutputFile(fileName + "_normalized", 
				ssd.getNormalizedData(), 0, 
				ssd.getNormalizedData().size()-1, 0);	
		/*
		u.writeOutputFile(fileName, 
				ssd.getSmoothedData(), 0, 
				ssd.getSmoothedData().size()-1, 0);	
		*/
		
		// Save computed SD list of the smoothed data
		u.writeOutputFile(fileName + "_sd_raw", 
				ssd.getSD(), 0, ssd.getSD().size()-1, 0);	
		
		
		// Save detected steady state data
		ArrayList<Long> tmp = new ArrayList<Long>(ssd.getNormalizedData().subList(
				sPoint, ssd.getNormalizedData().size()));

		u.writeOutputFile(fileName + "_steady", tmp, 0, 
				ssd.getNormalizedData().size() - sPoint -1, sPoint);

		// Save steady parts
		u.writeOutputFile(fileName + "_steady_parts",
				ssd.getFilteredData(), 0, 
				ssd.getSmoothedData().size() - 1, 0);
				
		// Save Union of the steady parts
		u.writeOutputFile(fileName + "_union", 
				ssd.getSteadyPartUnion(), 0,
				ssd.getSteadyPartUnion().size() - 1, 0);

		// Save SD list of the union of steady parts
		u.writeOutputFile(fileName + "_union_sd",
				ssd.getUnionSD(), 0, ssd.getUnionSD().size() - 1, 0);
		
	}
}
