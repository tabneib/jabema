package net.cliseau.lib.policy;

import net.cliseau.runtime.javacor.CriticalEvent;
import net.cliseau.runtime.javacor.DelegationReqResp;
import net.cliseau.runtime.javacor.EnforcementDecision;
import net.cliseau.runtime.javacor.LocalPolicy;
import net.cliseau.runtime.javacor.LocalPolicyResponse;

public class BucketingPolicy extends LocalPolicy{

	public BucketingPolicy(String identifier) {
		super(identifier);
		// TODO Auto-generated constructor stub
	}

	@Override
	public LocalPolicyResponse localRequest(CriticalEvent ev)
			throws IllegalArgumentException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public LocalPolicyResponse remoteRequest(DelegationReqResp dr)
			throws IllegalArgumentException {
		// TODO Auto-generated method stub
		return null;
	}

}
