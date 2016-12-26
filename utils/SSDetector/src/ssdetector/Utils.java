package ssdetector;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

public class Utils {

	private BufferedWriter bw;

	/**
	 * 
	 * @param a
	 * @return
	 */
	public long average(long[] a) {
		long sum = 0;
		for (int i = 0; i < a.length; i++) {
			sum += a[i];
		}

		return sum / a.length;

	}
	
	
	/**
	 * 
	 * @param a
	 * @return
	 */
	public long average(ArrayList<Long> a) {
		long sum = 0;
		for (int i = 0; i < a.size(); i++) {
			sum += a.get(i);
		}

		return sum / a.size();

	}

	/**
	 * 
	 * @param a
	 * @return
	 */
	public Double median(Double[] a) {
		Arrays.sort(a);

		int left = 0;
		int right = a.length - 1;
		int median = 0;

		median = (left + right) / 2;

		return a[median];
	}

	/**
	 * 
	 * @param a
	 * @return
	 */
	public Double[] MedianOutlierRejector(Double[] a) {
		double median = median(a);
		double auxMedian;
		double dev = 0.0;
		int i = 0; // counter
		int r = 1;
		ArrayList<Double> ret = new ArrayList<Double>();
		Double aux[] = new Double[a.length];

		// set of all absolute differences between the elements of M and
		// median(M).
		for (i = 0; i < a.length; i++) {
			aux[i] = Math.abs(a[i] - median);
			System.out.println(aux[i]);
		}

		auxMedian = median(aux);
		System.out.println("Median of aux: " + auxMedian);
		for (i = 0; i < a.length; i++) {
			dev = Math.abs(a[i] - median);
			if (!(dev >= r * auxMedian))
				ret.add(a[i]);
			// System.out.println(a[i]);
		}
		return listToArray(ret);
	}

	public Double[] listToArray(ArrayList<Double> list) {
		Double aux[] = new Double[list.size()];

		for (int i = 0; i < aux.length; i++) {
			aux[i] = list.get(i);
		}

		return aux;
	}

	public BufferedWriter getBufferWriter() {
		return bw;
	}

	public void setBufferWriter(BufferedWriter bw) {
		this.bw = bw;
	}

	/**
	 * 
	 * @return
	 */
	public boolean closeBW() {
		try {
			this.bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}

		return true;
	}

	/**
	 * 
	 * @param path
	 */
	public void createBW(String path) {
		File f = new File(path);
		if (!f.getParentFile().exists())
			f.getParentFile().mkdirs();
		
		try {
			this.setBufferWriter(new BufferedWriter(new FileWriter(path, true)));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * @param msg
	 */
	public void writeFile(String msg) {
		try {
			this.getBufferWriter().append(msg);
			this.getBufferWriter().newLine();
			this.getBufferWriter().flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 
	 * @param path
	 * @return
	 */
	public ArrayList<Long> readDataFile(String path) {
		
		ArrayList<Long> result = new ArrayList<Long>();
		try (BufferedReader br = new BufferedReader(new FileReader(path))) {
		    String line;
		    while ((line = br.readLine()) != null) {
		       result.add(Long.parseLong(line));
		    }
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 
	 * @param path
	 * @param data
	 */
	public void writeDataFile(String path, ArrayList<Long> data) {
		this.createBW(path);
		for (int i = 0; i < data.size(); i++){
			this.writeFile(String.valueOf(data.get(i)));
		}
		//closing the current buffered writer
		this.closeBW();
	}
	
	

	/**
	 * TODO comment me !
	 * @param fileName
	 * @param data
	 * @param fromIndex
	 * @param toIndex
	 */
	public void writeOutputFile(String fileName, ArrayList<?> data, 
			int fromIndex, int toIndex, int startIndex) {
		PrintWriter w = null;
		
		// Debug
		//System.out.println("Going to write output data !!!!!!!!!!!!!!!!!!!!!");
		//System.out.println("Data: " + data);
		try {
			w = new PrintWriter(fileName);
			for (int i = fromIndex; i <= toIndex; i++) {
				w.println(startIndex + "\t" + data.get(i));
				startIndex++;
			}
			w.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (w != null) w.close();	
		}	
	}
	

	/**
	 * TODO comment me !
	 * @param fileName
	 * @param data
	 * @param fromIndex
	 * @param toIndex
	 */
	public void writeNormalOutputFile(String fileName, ArrayList<?> data, 
			int fromIndex, int toIndex, int startIndex) {
		PrintWriter w = null;
		
		// Debug
		//System.out.println("Going to write output data !!!!!!!!!!!!!!!!!!!!!");
		//System.out.println("Data: " + data);
		try {
			w = new PrintWriter(fileName);
			for (int i = fromIndex; i <= toIndex; i++) {
				w.println(data.get(i));
				startIndex++;
			}
			w.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (w != null) w.close();	
		}	
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
	 * Removes all outliers from measured running time data
	 * @param window
	 * 			Size of the sliding window
	 * @param factor
	 * 			Factor for the Median-based outlier rejector
	 * @return
	 */
	public ArrayList<Long> removeOutlier(ArrayList<Long> window, double factor){
		
		
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
	
	
	
}


