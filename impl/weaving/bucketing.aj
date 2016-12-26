package serversidechannel;
import serversidechannel.Hash;
import java.lang.Thread;


/**
	@author: Hoang-Duong Nguyen
**/
public aspect bucketing {
	
	private long startTime;
	private final long bucket1 = 100000000L; //
	private final long bucket2 = 200000000L; //
	private final long bucket3 = 300000000L; //
	

	/* class of the method, argument of the method, returned type */
	pointcut checkRequest(serversidechannel.Hash h, String request > boolean):
	call(boolean serversidechannel.Hash.checkRequest(String))
	&& target(h) && args(request);

	// Before executing
	before(serversidechannel.Hash h, String request): checkRequest(h, request){
		startTime = System.nanoTime();
	}

	// After executing
	after(serversidechannel.Hash h, String request): checkRequest(h, request){
		long duration = System.nanoTime() - startTime;
		
		/* info needed for bucket 1 */
		long millisFlushB1 = (this.bucket1 - duration);
		int nanosFlushB1 = (int) (millisFlushB1 % 1000000);
		millisFlushB1 = millisFlushB1 / 1000000; // converting to milliseconds

		/* info needed for bucket 2 */
		long millisFlushB2 = (this.bucket2 - duration);
		int nanosFlushB2 = (int) (millisFlushB2 % 1000000);
		millisFlushB2 = millisFlushB2 / 1000000; // converting to milliseconds

		/* info needed for bucket 3 */
		long millisFlushB3 = (this.bucket3 - duration);
		int nanosFlushB3 = (int) (millisFlushB3 % 1000000);
		millisFlushB3 = millisFlushB3 / 1000000; // converting to milliseconds

		/* temp - remove later */
		//u.writeFile("millisBucket-1: " + Long.toString(millisFlushB1) + " nanosBucket-1: "
		//		+ Integer.toString(nanosFlushB1));
		//u.writeFile("millisBucket-2: " + Long.toString(millisFlushB2) + " nanosBucket-2: "
		//		+ Integer.toString(nanosFlushB2));
		//u.writeFile("millisBucket-3: " + Long.toString(millisFlushB3) + " nanosBucket-3: "
		//		+ Integer.toString(nanosFlushB3));
		//u.closeBW();

		try {
			if (duration < this.bucket1) {
				/* event is in bucket 01 */
				//u.writeFile("Bucket01: " + Long.toString(duration));
				//Thread.sleep(millisFlushB1, nanosFlushB1);
			} else if (duration < this.bucket2) {
				//u.writeFile("Bucket02: " + Long.toString(duration));
				/* event is in bucket 02 */
				//Thread.sleep(millisFlushB2, nanosFlushB2);
			} else if (duration < this.bucket3) {
				//u.writeFile("Bucket03: " + Long.toString(duration));
				//Thread.sleep(millisFlushB3, nanosFlushB3);
			}else{ //infinite case
				Thread.sleep(0);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	

	}

}

