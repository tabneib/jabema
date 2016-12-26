/* Copyright (c) 2011-2014 Richard Gay \<gay@mais.informatik.tu-darmstadt.de\>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is furnished to do
 * so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import java.io.IOException;
import java.net.UnknownHostException;
import net.cliseau.runtime.javacor.CriticalEvent;
import net.cliseau.runtime.javacor.EnforcementDecision;
import net.cliseau.runtime.javacor.LocalPolicy;
import net.cliseau.runtime.javacor.LocalPolicyResponse;
import net.cliseau.runtime.javatarget.Enforcer;
import net.cliseau.runtime.javatarget.CoordinatorInterface;
/*<! Note: whenever you modify the above list of imports to include packages
 *   which are not in the Java API, then check and update
 *   JavaUnitInstantiation.getInlinedDependencies()! !>*/
<Imports>

/**
 * This is the aspect for doing a "full sequential inlining" (FSI)
 * of the enforcement mechanism.
 *
 * In this variant, we leave out the coordinator (i.e., coordinated
 * deciding is not possible with this variant.
 */
aspect <AspectName> {
	/** The identifier of this system node. */
	private static final String identifier = "<Identifier>";
	/** The policy object to use for decisiong. */
	private LocalPolicy localPolicy;

	/**
	 * Constructor of the aspect.
	 */
	<AspectName>() {
		localPolicy = new <LocalPolicyClass>(identifier);
		policy.setConfigResource(getClass().getClassLoader(), "<PolicyConfigRes>");
	}
<Pointcuts>
<Advice>
}
