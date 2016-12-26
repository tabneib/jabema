/*
 * @author Yuri Gil Dantas
 * @author Tobias Hamann 
 */

package bucketing;

import net.cliseau.runtime.javacor.CriticalEvent;
import net.cliseau.runtime.javatarget.CriticalEventFactory;
import serversidechannel.Hash;
import bucketing.BucketingEvent;

public class BucketingEventFactory implements CriticalEventFactory {

/*
 * @method: checkHash (encapsulated method)
 * 
 * Creates the critical event, i.e., gets the current
 * time of the the incoming event
 * 
 * @param: 
 * 
 * 	h - The class Hash
 *  hash - The string received by the method checkHash
 *  
 * @return:
 *  
 *  An instance of BucketingEvent that contains the initial time of the event
 *  
 */
public static CriticalEvent checkRequest(Hash h, String request){
	BucketingEvent bucketEvent = new BucketingEvent(System.nanoTime());
	return bucketEvent;
}

}
