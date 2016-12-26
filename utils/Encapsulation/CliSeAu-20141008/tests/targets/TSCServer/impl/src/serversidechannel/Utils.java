package serversidechannel;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.security.MessageDigest;

public class Utils {

	private BufferedWriter bw;
	
	public boolean myOwnEquals(String s1, String s2) {

		if (s1.length() != s2.length())
			return false;

		for (int i = 0; i < s1.length(); i++) {
			if (s1.charAt(i) != s2.charAt(i))
				return false;
		}

		return true;

	}

	public BufferedWriter getBufferWriter() {
		return bw;
	}

	public void setBufferWriter(BufferedWriter bw) {
		this.bw = bw;
	}

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

	public static String convertByteToHex(byte data[]) {
		StringBuffer hexData = new StringBuffer();
		for (int byteIndex = 0; byteIndex < data.length; byteIndex++)
			hexData.append(Integer.toString((data[byteIndex] & 0xff) + 0x100, 16).substring(1));

		return hexData.toString();
	}

	public static String hashText(String textToHash) throws Exception {
		final MessageDigest sha512 = MessageDigest.getInstance("SHA-512");
		sha512.update(textToHash.getBytes());

		return convertByteToHex(sha512.digest());
	}

}
