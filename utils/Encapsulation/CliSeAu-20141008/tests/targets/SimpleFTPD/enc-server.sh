#!/bin/sh
# Copyright (c) 2011-2012 Richard Gay <gay@mais.informatik.tu-darmstadt.de>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
if test $# -ne 1; then
	echo "Usage: $0 <server numbers>"
	exit 1
fi

cd `dirname $0`
BASE=`pwd`

# Start servers
for i in $1; do
	cd $BASE/data/server$i
	java -jar /tmp/SimpleFTPD/id-$i/JavaStarter.jar &
	#java -jar /tmp/SimpleFTPD/id-$i/JavaStarter.jar > /dev/null &
	SRV[$i]=$!
done

echo "All servers started. Enter 'exit' to kill them."
read ACTION
if test x$ACTION != "xexit"; then
	exit 0
fi

# Clean up
for i in $1; do
	kill ${SRV[$i]}
	pkill -P ${SRV[$i]}
done
echo "done."
