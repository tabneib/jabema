package client;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

public class Starter {

	private static int measurements;
	//private static int normalizationWindowSize = 50;
	//private static int smoothingWindowSize = 10;
	//private static int outlierFactor = 3;
	//private static int sdWindowSize = 5;
	//private static int sdOutlierThreshold = 1000;
	//private static int steadyMeasurements = 10;
	
	private static int param;
	
	public static void main(String[] args) {
		/* Attacker/Client side */
		

		param = Integer.parseInt(args[0]); //either correctKey (0), longestKey (1), middleKey (2) or shortestKey (3)
		int id = Integer.parseInt(args[1]);
		int port = Integer.parseInt(args[2]);
		measurements = Integer.parseInt(args[3]);
		connect(param,id,port);
	}
	
	
	/**
	 * 
	 * @param param
	 * @param id
	 * @param port
	 */
	private static void connect(int param, int id, int port){


		//String files[] = { "correct.txt", "longest.txt", "middle.txt", "shortest.txt" };
		String files[] = { "correct", "longest", "middle", "shortest" };
		/* variables */
		int repetitions = measurements; //how many times the attacker send a request to the server 
		long retTime[];
		
		String correctKEY = "e3288e7232b4d6dc0c704dbd450aad53e0b19d5591b94eb91667a602d0fdf72644e65ebbb78e3e3ab2019e1539165200aede40b0c2b33c6f1331becd203e3a42";
		String shortestKEY = "a3288e7232b4d6dc0c704dbd450aad53e0b19d5591b94eb91667a602d0fdf72644e65ebbb78e3e3ab2019e1539165200aede40b0c2b33c6f1331becd203e3a42";
		String middleKEY = "e3288e7232b4d6dc0c704dbd450aad53e0b19d5591b94eb91667a602d0fdf72544e65ebbb78e3e3ab2019e1539165200aede40b0c2b33c6f1331becd203e3a42";
		//String longestKEY = "e3288e7232b4d6dc0c704dbd450aad53e0b19d5591b94eb91667a602d0fdf72644e65ebbb78e3e3ab2019e1539165200aede40b0c2b33c6f1331becd203e3a41";
		// 12nd byte from the last byte
		//String longestKEY = "e3288e7232b4d6dc0c704dbd450aad53e0b19d5591b94eb91667a602d0fdf72644e65ebbb78e3e3ab2019e1539165200aede40b0c2b33c6f1332becd203e3a42";
		// 6th byte from the last byte
		//String longestKEY = "e3288e7232b4d6dc0c704dbd450aad53e0b19d5591b94eb91667a602d0fdf72644e65ebbb78e3e3ab2019e1539165200aede40b0c2b33c6f1331becd213e3a42";
		// 3rd byte from the last byte
		String longestKEY = "e3288e7232b4d6dc0c704dbd450aad53e0b19d5591b94eb91667a602d0fdf72644e65ebbb78e3e3ab2019e1539165200aede40b0c2b33c6f1331becd203e0a42";
		
		
		/* attack inputs: correct -> shortest (feel free to use different inputs) */
		String keys[] = new String[4];
		keys[0] = correctKEY;
		keys[1] = longestKEY;
		keys[2] = middleKEY;
		keys[3] = shortestKEY;
		
		
		/* instantiations */
		System.out.println("CLIENT-----------> Port: " + port + "  MAC: " + param);
		Communication c = new Communication("127.0.0.1", port);
		c.connecting();
		
		// @NHD: until now utils is just used to write the retTime into a file
		Utils u = new Utils();
		

		// absolute path to the directory that stores the output file
		//String path = "./output";
		// TODO throw path to args[]
		String path = "/home/nhd/hiwi/output/" + files[param] + "/";
		
		// creating a bufferedwriter object such that the code can write on it later
		//u.createBW(path + files[param]); 

		// sending the hmac key
		//retTime = c.chatting(keys[param], repetitions);
		c.chatting(keys[param], repetitions);
		
		//writing the response time into the file
		
		// @NHD: take only the first communication round !?
		// @NHD:  => take the one for which the server is in its steady state
		
		
		
		
		
		
		
		// Apply the determining technique for this data set !
		
		System.out.println("|---------------------------------------------|");
		/*
		SSDeterminer ssd = new SSDeterminer(measurements, normalizationWindowSize,
				smoothingWindowSize, outlierFactor, sdWindowSize, sdOutlierThreshold);
		ssd.add(retTime);
		ssd.smoothOutput();
		ssd.computeAllSD(ssd.getSmoothedData(), sdWindowSize);
		int sPoint = ssd.detectSteadyPoint();
		
		// TODO: bug in detectSteadyPoint() !!
		
		sPoint = 0;
		
		//System.out.println(">>>>>> Normalized Steady Point:           " + sPoint);
		ArrayList<Long> steadyData = 
				new ArrayList<Long>(ssd.getData().subList
						(ssd.normalizationWindowSize*sPoint, 
						ssd.normalizationWindowSize*sPoint + steadyMeasurements)); 
		*/

		// Write the average of the measurements in steady state into the output file
		//u.writeFile(String.valueOf(u.average(steadyData)));
		/*
		u.createBW(path + files[param] + id);
		for (int i = 0; i < retTime.length; i++){
			u.writeFile(String.valueOf(retTime[i]));
		}
		//closing the current buffered writer
		u.closeBW();
		c.closeConnection(); //closing the socket
		*/
	
		// At the end, kill all java processes 
		/*
		try {
			Process p = Runtime.getRuntime().exec(new String[]{"killall","java"});
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
		//System.exit(0);
	}
}

