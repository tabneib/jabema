package serversidechannel;

import java.io.IOException;
import java.util.ArrayList;

public class ServerStarter {

	/**
	 * 
	 * @param args
	 * [0]	param
	 * [1]	port
	 * [2]	absolute path to the output directory
	 * [3]	number of measurements
	 * [4]	ID of the current sample
	 */
	public static void ServerStarter(String[] args) {
		// TODO Auto-generated method stub
		/* Server side */
		// start port: 1112
		Utils u = new Utils();
		int param = Integer.parseInt(args[0]); //port
		int port = Integer.parseInt(args[1]); //port
		String path = args[2];
		int measurements = Integer.parseInt(args[3]);
		int id = Integer.parseInt(args[4]);
		//String files[] = { "correct.txt", "longest.txt", "middle.txt", "shortest.txt" };
				String files[] = { "correct", "longest", "middle", "shortest" };
		
		System.out.println("------------------> Port:  " + port);
		Communication c = new Communication(port);
		c.connecting(); //creating server socket

		/* listening ... */
		//while (true) {
		ArrayList<Long> retTime = c.startingCommunication(measurements);
		//}
			

		// Write the average of the measurements in steady state into the output file
		//u.writeFile(String.valueOf(u.average(steadyData)));
		path = path + files[param] + "/";
		u.createBW(path + files[param] + id);
		for (int i = 0; i < retTime.size(); i++){
			u.writeFile(String.valueOf(retTime.get(i)));
		}
		//closing the current buffered writer
		u.closeBW();
		System.out.println("Server - Output file: " + files[param] + id);
		
		
			// At the end, kill all java processes 
		try {
			Process p = Runtime.getRuntime().exec(new String[]{"killall","java"});
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
			
	}

}
