package serversidechannel;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;

//import javax.rmi.CORBA.Util;

public class Communication {
	private ServerSocket sSocket;
	private int port;
	public Communication(int port) {
		this.setPort(port);
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public ServerSocket getserverSocket() {
		return sSocket;
	}

	public void setserverSocket(ServerSocket sSocket) {
		this.sSocket = sSocket;
	}

	/* connect the socket */
	public boolean connecting() {
		ServerSocket serverSocket;
		try {
			serverSocket = new ServerSocket(this.getPort());
		} catch (IOException e) {
			System.err.println("Server: Could not listen on port: " + this.getPort());
			return false;
		}
		this.setserverSocket(serverSocket);
		return true;
	}

	/* start the communication via socket and check the incoming hmac */
	public ArrayList<Long> startingCommunication(int measurements) {
		
		long start = 0;
		long end = 0;
		ArrayList<Long> time = new ArrayList<Long>(measurements);
		

		PrintWriter out; 
		BufferedReader in;
		
		int count = 1;
		
		Hash hash = new Hash();
		Socket clientSocket = null;
		System.out.println("Server: Waiting for connection...");

		try {
			clientSocket = this.getserverSocket().accept();
		} catch (IOException e) {
			System.err.println("Server: Accept failed.");
			System.exit(1);
		}

		System.out.println("Server: Connection successful");
		System.out.println("Server: Waiting for input.....");


		try {
			out = new PrintWriter(clientSocket.getOutputStream(), true);
			in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

			String inputLine;

			/* getting the incoming input */
			while ((count <= measurements + 2) && (inputLine = in.readLine()) != null) {
				// start counting time
				start = System.nanoTime();
				if (hash.checkRequest(inputLine)){
					
					// stop counting time
					end = System.nanoTime();
					out.println("MAC checked"); 
				}
				else{
					// stop counting time
					end = System.nanoTime();
					out.println("MAC checked");
				}
				time.add(end - start);
				count++;

			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		System.out.println("------------> Server - received msg: " + (count-1));
		
		//closing the socket
		/*try {
			clientSocket.close();
			this.getserverSocket().close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		*/
		return time;
	

	}

}
