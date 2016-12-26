/*
 * @author Yuri Gil Dantas
 * @author Tobias Hamann 
 */


package bucketing;

import net.cliseau.runtime.javacor.CriticalEvent;
import net.cliseau.runtime.javacor.DelegationReqResp;
import net.cliseau.runtime.javacor.LocalPolicy;
import net.cliseau.runtime.javacor.LocalPolicyResponse;


public class Bucketing extends LocalPolicy{

  public Bucketing(String str){
	super(str);
  }
  /*
   * Method: LocalPolicyResponse
   * 
   * Always permit the incoming event
   * 
   */
  @Override public LocalPolicyResponse localRequest(CriticalEvent ev)
	throws IllegalArgumentException{
		return new EventDecision((BucketingEvent) ev);
	}

  @Override public LocalPolicyResponse remoteRequest(DelegationReqResp dr)
	throws IllegalArgumentException {
		return null;
	}

}


