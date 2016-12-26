/*
 * @author Yuri Gil Dantas
 * @author Tobias Hamann 
 */

package bucketing;

import net.cliseau.runtime.javacor.EnforcementDecision;
import bucketing.BucketingEvent;

public class EventDecision implements EnforcementDecision{

	private BucketingEvent bEvent;


public EventDecision(BucketingEvent bEvent){
	this.bEvent = bEvent;
}


public void setBucketingEvent(BucketingEvent bEvent){
	this.bEvent = bEvent;
}

public BucketingEvent getBucketingEvent(){
	return this.bEvent;
}


}
