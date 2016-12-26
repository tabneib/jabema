/*
 * @author Yuri Gil Dantas
 * @author Tobias Hamann 
 */

package bucketing;

import bucketing.BucketingEnforcer;
import net.cliseau.runtime.javacor.EnforcementDecision;
import net.cliseau.runtime.javacor.CriticalEvent;
import net.cliseau.runtime.javatarget.Enforcer;
import net.cliseau.runtime.javatarget.EnforcerFactory;
import bucketing.EventDecision;


public class BucketingEnforcerFactory implements EnforcerFactory {
	/* Override did not work */
	public static Enforcer fromDecision(final EnforcementDecision ed){
		EventDecision ted = (EventDecision) ed;

		if (ted != null){
			return new BucketingEnforcer(ted.getBucketingEvent());
		}else{
			return null;
		}

	}
	/* Override did not work */
	 public static Enforcer fallback(final CriticalEvent ev){
		return new BucketingEnforcer((BucketingEvent) ev);
	}
}
