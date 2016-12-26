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
package net.cliseau.runtime.javacor;

import java.io.Serializable;

/**
 * Data type for critical events.
 *
 * This interface defines the data type which represents critical events.
 * Objects of this type are transmitted from coordinators to local policies
 * responses. They must be constructable from the input that is sent to the
 * coordinator by the enforcer of the same CliSeAu unit.
 *
 * For Java target programs, classes implementing this interface can (and
 * probably should) also be used from within the interceptor. For other target
 * programming languages, the data type for critical events used by the
 * interceptor should reflect the type used by the coordinator and local policy
 * (e.g., by having the same fields of the same or corresponding types).
 *
 * When implementing CriticalEvent classes for use with Java target programs
 * (and when Java's serialization is used), it has to be taken care that neither
 * the fields of the classes nor the methods reference any type that is not
 * known to the Coordinator. Example: if the triggering event of the target
 * program is an operation on objects of target-specific type "Foo", then this
 * target should not be stored in a field of the CriticalEvent object for this
 * trigger. Also, the derived CriticalEvent class should not offer, e.g., a
 * constructor parametric in objects of type "Foo". All the construction work
 * should be done by a CriticalEventFactory.
 *
 * Currently, the interface does not impose any requirement on implementing
 * classes, i.e., the interface does not contain any methods.
 *
 * @see Coordinator
 * @see LocalPolicy
 * @see net.cliseau.runtime.javatarget.CriticalEventFactory
 */
public interface CriticalEvent extends Serializable {
}
