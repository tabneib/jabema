/* Copyright (c) 2011-2012 Richard Gay <gay@mais.informatik.tu-darmstadt.de>
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
package net.cliseau.composer;

/**
 * Base class for exceptions occurring during unit generation.
 *
 * This shall serve as a base class for exceptions that can occur during the
 * generation of an encapsulated unit. Possible examples are
 *  - instrumentation errors (e.g., AspectJ fails)
 *  - instantiation errors (e.g., instrumentation pointcuts are specified invalidly)
 *
 *  @todo Consider adding a unit identifier field to this class.
 */
public abstract class UnitGenerationException extends Exception {
	/**
	 * Construct a UnitGenerationException.
	 *
	 * @param message The message accompanying the exception.
	 */
	public UnitGenerationException(final String message) { super(message); }
}
