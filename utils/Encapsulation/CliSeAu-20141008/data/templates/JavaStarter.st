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
import java.io.File;
import java.io.IOException;
import java.net.ServerSocket;
import java.util.Arrays;
import java.util.LinkedList;
import org.apache.log4j.BasicConfigurator; // for debugging
import org.apache.log4j.Logger; // for debugging
import net.cliseau.runtime.javacor.Coordinator;
import net.cliseau.runtime.javacor.CoordinatorAddressing;
import net.cliseau.runtime.javacor.LocalPolicy;
import net.cliseau.runtime.sync.StartupBarrier;
import net.cliseau.utils.CommandRunner;
/*<! Note: whenever you modify the above list of imports to include packages
 *   which are not in the Java API, then check and update
 *   JavaUnitInstantiation.getStartupDependencies()! !>*/

/**
 * Starter for the unit of a CliSeAu instantiation.
 *
 * This program starts a unit and the target agent that it encapsulates.
 */
class JavaStarter {
	/** The identifier of this system node. */
	private static final String identifier = "<Identifier>";

	/**
	 * Construct an addressing object for starting the Coordinator.
	 *
	 * This method shall be filled with code for constructing a
	 * CoordinatorAddressing object.
	 *
	 * @return Object with addressing information for constructing a Coordinator.
	 */
	private static CoordinatorAddressing getAddressing() {
		<AddressingSetupCode>
	}

	/**
	 * Construct a system command for exec() from the given command line arguments.
	 *
	 * The system command is supposed to execute the Java target program. The
	 * target program has to be contained in a JAR file (<JARfile>) and is run in
	 * a Java virtual machine (<JavaVM>). The command line arguments given to
	 * this function are searched for a "--" parameter. All parameters before this
	 * argument are considered to be parameters for the Java virtual machine
	 * while all parameters after the argument are considered to be parameters
	 * for the target program itself.
	 *
	 * @param args Array of command line arguments.
	 * @todo Currently, this method is specific for Java target programs. Is
	 *       there a way to make this independent here and use, e.g., a different
	 *       template to deal with the pecularities of starting a Java target
	 *       program?
	 * @todo Is there a more elegant approach to passing on the parameters?
	 *       Ideally, the command line used for running the original program
	 *       should differ as little as possible.
	 */
	private static String[] getStartupCommand(final String args[]) {
		// find the separating "--" argument
		int sep_pos;
		for (sep_pos=0; sep_pos\<args.length; ++sep_pos) {
			if (args[sep_pos].equals("--")) { break; }
		}
		if (sep_pos == args.length) { sep_pos = -1;  }

		// create the command to run the target
		LinkedList\<String\> cmd = new LinkedList\<String\>();
		cmd.addLast("<JavaVM>");
		// copy all arguments before the "--" before the "-jar" argument: these
		// are considered to be arguments for the Java VM itself.
		if (sep_pos \> 0) {
			cmd.addAll(Arrays.asList(Arrays.copyOfRange(args, 0, sep_pos)));
		}
		// add the parameter specifying the JAR file
		// inspired by
		//   http://stackoverflow.com/questions/320542/how-to-get-the-path-of-a-running-jar-file
		String starterDir = new File(JavaStarter.class.getProtectionDomain().getCodeSource().getLocation().getPath()).getParent();
		cmd.addLast("-jar");
		cmd.addLast(starterDir + File.separator + "<JARfile>");
		// copy all arguments after the "--": these are considered to be arguments
		// for the target program.
		cmd.addAll(Arrays.asList(Arrays.copyOfRange(args, sep_pos+1, args.length)));
		return cmd.toArray(new String[0]);
	}

	/**
	 * Run the unit's instrumented target agent.
	 *
	 * This (main) method starts the local coordinator and, once it is ensured
	 * that all other CliSeAu units in the distributed system are running,
	 * starts the (instrumented) local target program.
	 *
	 * @param args Command line arguments
	 * @exception IOException TODO: check where this exception can be thrown
	 */
	public static void main(final String args[])
			throws IOException { //FIXME
		BasicConfigurator.configure(); // log4j
		final Logger logger = Logger.getLogger("CliSeAu unit@" + identifier);
		final org.apache.log4j.Level logLevel = org.apache.log4j.Level.<LogLevel>;
		logger.setLevel(logLevel);

		// Step 1: initialize all required data structures
		//     (a) coordinator addressing
		final CoordinatorAddressing addressing = getAddressing();

		//     (b) local coordinator socket
		ServerSocket local_socket  = addressing.getPrivateServer();
		local_socket.setSoTimeout(1000); //FIXME: just for the sake of debugging

		//     (c) remote coordinator socket
		ServerSocket remote_socket = addressing.getPublicServer(identifier);
		remote_socket.setSoTimeout(1000); //FIXME: just for the sake of debugging

		//     (d) local policy creation
		LocalPolicy policy = new <LocalPolicyClass>(identifier);

		//     (e) policy parameters
		policy.setConfigResource(JavaStarter.class.getClassLoader(), "<PolicyConfigRes>");

		// Step 2: create the local coordinator
		Coordinator coor = new Coordinator(identifier, local_socket, remote_socket, addressing, policy, logLevel);

		// Step 3: fork off a thread that starts the local target program
		//         once *all* CliSeAu units are ready
		Thread program_thread = new Thread() {
			public void run() {
				// Step 3a: perform a barrier synchronization
				//          such that the following code can only be executed if
				//          all other coordinators in the system have been started
				StartupBarrier barrier = new StartupBarrier(addressing, identifier, logLevel);
				barrier.run();
				// Step 3b: start the program
				try {
					logger.info("Started the local program");
					CommandRunner.exec(getStartupCommand(args));
					logger.info("Local program terminated");
				} catch (IOException e) {
					logger.warn("Program caused IO exception [" + e.getMessage() + "]");
				}
				//TODO: will this thread now terminate or does it wait for the program to terminate first
				//      even though we do not do 'p.waitFor()'
			}
		};
		program_thread.start();

		// Step 4: start the local coordinator
		coor.run();
	}
}
