/*<!
 * Copyright (c) 2011-2012 Richard Gay <gay@mais.informatik.tu-darmstadt.de>
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
 !>*/
<ReturnType> around(<TypedParameters>) : <PointcutName>(<Parameters>) {
	<if(measureTime)>
	double duration = System.nanoTime();
	double origtime = 0.0;
	<endif>

	// Transform the pointcut with its actual parameters to a CriticalEvent
	CriticalEvent ev = <CriticalEventFactory>.<PointcutName>(<Parameters>);

	// Obtain an Enforcer for the CriticalEvent with the help of the local
	// coordinator or, in case of failure, create a fallback Enforcer.
	Enforcer enf = null;
	try {
		CoordinatorInterface.send(ev);
		EnforcementDecision ed = CoordinatorInterface.receive();
		enf = <EnforcerFactory>.fromDecision(ed);
	} catch (IOException e) {
		System.out.println("IOException [" + e.getMessage() + "]"); //FIXME
	} catch (ClassNotFoundException e) {
		System.out.println("ClassNotFoundException"); //FIXME
	}
	if (enf == null) {
		// If obtaining an enforcement decision failed, then we must make a
		// fallback enforcement for the given CriticalEvent.
		enf = <EnforcerFactory>.fallback(ev);
	}

	// Below, we perform the enforcement.
	// <! Case distinctions have to be made depending on whether the pointcut has a return value or not. !>
	enf.before();
	<if(hasReturnType)>
	<ReturnType> result;
	<endif>
	if (!enf.suppress()) {
		<if(measureTime)>origtime = System.nanoTime();<endif>
		<if(hasReturnType)>result = <endif> proceed(<Parameters>);
		<if(measureTime)>origtime = System.nanoTime() - origtime;<endif>
	} else {
		//FIXME: in case of type casting failures, the result ("null") may not be
		//       the desired value; in case of <ReturnType>!=<ObjReturnType>,
		//       auto-unboxing may even result in a NullPointerException to be
		//       thrown!
		<if(hasReturnType)>result = (<ObjReturnType>)enf.getReturnValue(<ObjReturnType>.class);<endif>
	}
	enf.after();

	<if(measureTime)>
	// measure the timing for the enforcement
	// note that this excludes any overhead that AspectJ causes before
	// and after the advice is executed
	duration = System.nanoTime() - duration - origtime;
	System.err.println(">>> t = " + (duration/1000000)); // show time in milliseconds
	<endif>

	<if(hasReturnType)>
	return result;
	<endif>
}
