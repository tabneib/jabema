/*
 * @author Yuri Gil Dantas
 * @author Tobias Hamann
 */

package bucketing;

import bucketing.UtilsBucketing;
import net.cliseau.runtime.javatarget.Enforcer;
import bucketing.BucketingEvent;
import java.lang.Math;
import java.lang.Thread;

public class BucketingEnforcer implements Enforcer {

	private BucketingEvent bEvent;
	private final long bucket1 = 100000000L; //
	private final long bucket2 = 200000000L; //
	private final long bucket3 = 300000000L; //

	public BucketingEnforcer(BucketingEvent event) {
		this.bEvent = event;
	}

	@Override
	public void before() {
	}

	@Override
	public boolean suppress() {
		return false;
	}

	/*
	 * @method: After() - Bucketing
	 *
	 * Calculates when to release events based on the
	 * duration (endTime - initTime) of the event
	 *
	 *  */
	@Override
	public void after() {
		//UtilsBucketing u = new UtilsBucketing();

		long endTime = System.nanoTime(); // get the current time, which is the
	                                          // end time of the string comparison
		long initTime = this.bEvent.getInitTime(); // get the initial time
		long duration = endTime - initTime; // overall duration of the string comparison

		/* temp - remove later */
		//u.createBW("path");
		//u.writeFile(Long.toString(duration));
		//u.writeFile("Duration: " + Long.toString(duration));
		//u.writeFile("bucket1: " + Long.toString(this.bucket1));
		//u.writeFile("bucket2: " + Long.toString(this.bucket2));

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

	@Override
	public Object getReturnValue(Class c) {
		return null;
	}

}
