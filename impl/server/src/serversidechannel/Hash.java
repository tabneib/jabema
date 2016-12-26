package serversidechannel;

public class Hash {
	
	private final String key = "e3288e7232b4d6dc0c704dbd450aad53e0b19d5591b94eb91667a602d0fdf72644e65ebbb78e3e3ab2019e1539165200aede40b0c2b33c6f1331becd203e3a42";

	/* methot that checks the incoming user request */
	public boolean checkRequest(String request){
		//return this.key.equals(request); //here is the method that leaks the key by measuring the execution time
		int keyLength = key.length();

		if (keyLength == request.length()) {
			char v1[] = key.toCharArray();
		        char v2[] = request.toCharArray();
		        int i = 0;
		        while (keyLength-- != 0) {
		            if (v1[i] != v2[i])
       				return false;
			    i++;
		        }
		        return true;
		}
		return false;
	}

}
