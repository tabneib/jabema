/*
 * @author Yuri Gil Dantas
 * @author Tobias Hamann 
 */


package bucketing;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class UtilsBucketing {

	private BufferedWriter bw;

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
	
}	
