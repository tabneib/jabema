/*
 * @author Yuri Gil Dantas
 * @author Tobias Hamann 
 */

package bucketing;

import net.cliseau.runtime.javacor.CriticalEvent;

public class BucketingEvent implements CriticalEvent {

	private long initTime;
	private long endTime;


public BucketingEvent(long init){
	this.setInitTime(init);
//	this.setEndTime(end);
}

public void setInitTime(long init){
	this.initTime = init;
}

public void setEndTime(long end){
	this.endTime = end;
}

public long getInitTime(){
	return this.initTime;
}

public long getEndTime(){
	return this.endTime;
}

}
