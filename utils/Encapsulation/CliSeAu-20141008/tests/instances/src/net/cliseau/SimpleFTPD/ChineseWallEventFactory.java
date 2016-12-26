/* Copyright (c) 2011-2014 Richard Gay <gay@mais.informatik.tu-darmstadt.de>
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
package net.cliseau.SimpleFTPD;

import java.lang.reflect.Field;
import net.cliseau.runtime.javacor.CriticalEvent;
import net.cliseau.runtime.javatarget.CriticalEventFactory;
import net.cliseau.lib.policy.ChineseWallPolicy;
import rath.tools.ftp.FTPChannel;

/**
 * Factory class for CriticalEvent objects of the SimpleFTP instantiation.
 *
 * For each pointcut there is a static factory method creating CriticalEvent
 * objects from the respective join point.
 *
 * @see ChineseWallPolicy.Event
 */
public class ChineseWallEventFactory implements CriticalEventFactory {
	/**
	 * Factory for CriticalEvent from "fileOp" pointcuts.
	 *
	 * This method assumes that a pointcut named "fileOp" is defined which has
	 * two parameters. The actual values of these parameters at runtime are
	 * passed to this method to construct a critical event from it.
	 *
	 * @param channel The affected FTP channel.
	 * @param fileName The file to be operated on.
	 * @return The constructed CriticalEvent.
	 */
	public static CriticalEvent fileOp(FTPChannel channel, String fileName) {
		String userName = "";
		try {
			Field userNameField = channel.getClass().getDeclaredField("username");
			userNameField.setAccessible(true);
			userName = (String)userNameField.get(channel);
		} catch (Exception e) {} //TODO
		String[] fileInfo = new java.io.File(fileName).getName().split(":");
		return new ChineseWallPolicy.Event(
			userName,
			fileInfo[0] /* COI */,
			fileInfo[1] /* company */,
			fileInfo[2] /* file name */);
	}
}
