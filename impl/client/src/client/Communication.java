package client;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;

public class Communication {

	private String hostname;
	private int port;
	private Socket s;
	private PrintWriter outStream;
	private BufferedReader inStream;

	public Communication(String server, int port) {
		this.setHostname(server);
		this.setPort(port);
	}

	//----------------------------------------------------------------------------------->
	//	Getters and Setters
	//<-----------------------------------------------------------------------------------
	
	public String getHostname() {
		return hostname;
	}

	public void setHostname(String hostname) {
		this.hostname = hostname;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public Socket getSocket() {
		return s;
	}

	public void setSocket(Socket s) {
		this.s = s;
	}

	public PrintWriter getOutStream() {
		return outStream;
	}

	public void setOutStream(PrintWriter outStream) {
		this.outStream = outStream;
	}

	public BufferedReader getInStream() {
		return inStream;
	}

	public void setInStream(BufferedReader inStream) {
		this.inStream = inStream;
	}

	

	//----------------------------------------------------------------------------------->
	//	Main stuff
	//<-----------------------------------------------------------------------------------
	
	/**
	 * 
	 * @return
	 */
	public boolean connecting() {
		Socket s;
		PrintWriter out = null;
		BufferedReader in = null;
		try {
			s = new Socket(this.getHostname(), this.getPort());
			out = new PrintWriter(s.getOutputStream(), true);
			in = new BufferedReader(new InputStreamReader(s.getInputStream()));
		} catch (UnknownHostException e) {
			System.err.println("Unknowing host: " + this.getHostname());
			return false;
		} catch (IOException e) {
			System.err.println("Couldn't get I/O for " + "the connection to: " + this.getHostname());
			return false;
		}

		this.setSocket(s);
		this.setOutStream(out);
		this.setInStream(in);

		return true;
	}

	/**
	 * 
	 * @return
	 */
	public boolean closeConnection() {

		try {
			this.getSocket().close();
			this.getOutStream().close();
			this.getInStream().close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}

		return true;
	}

	
	/* sends message(s) to the server */
	/**
	 * 
	 * @param msg
	 * @param length
	 * @return
	 */
	public void chatting(String msg, int length) {
		long start = 0;
		long end = 0;
		long time[] = new long[length];
		PrintWriter out = null;
		BufferedReader in = null;
		String tmp = "";
		try {
			out = new PrintWriter(this.getSocket().getOutputStream(), true);
			in = new BufferedReader(new InputStreamReader(this.getSocket().getInputStream()));
		} catch (IOException e) {
			e.printStackTrace();
		}

		// Send length times the same message
		for (int i = 0; i < length; i++) {
			
			// start counting time
			//start = System.nanoTime();
			
			// Send message
			out.println(msg);

			try {
				// Receive the response
				tmp =  in.readLine();
				
				// stop counting time
				//end = System.nanoTime();
				//time[i] = end - start;
				
				
				//System.out.println(time[i]);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		

		//return time;
	}

}
