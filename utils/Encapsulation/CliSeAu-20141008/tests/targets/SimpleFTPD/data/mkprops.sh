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
if test $# -ne 3 -a $# -ne 5; then
	echo "Usage: $0 <#servers> <dest-dir> <runtime-dir> [<fsize-min> <fsize-var>]"
	exit 1
fi

NUMSERVERS=$1
DESTREL=$2
RUNTIME=$3

# minimum size for "confidential" files and maximal variation of file size
if test $# -ne 5; then
	FMINSIZE=65536
	FVARSIZE=32768
else
	FMINSIZE=$4
	FVARSIZE=$5
fi
BASEPORT=2020
# number of companies, minus 1
NCOMPANIES=1

COI='bank'
DIRNAME=shared/auditing
FILENAME=BalanceSheet.xls
PROPFILE="ftp.properties"

# make directories absolute
DIR=`pwd`
cd `dirname $0`
SOURCE=`pwd`
cd $DIR
mkdir -p "$DESTREL"
cd "$DESTREL"
DESTINATION=`pwd`
echo $DESTINATION

# some bank names
BANK[0]='Citybank'
BANK[1]='DeutscheBank'

echo "Creating home and basic directory structure ..."
mkdir -p $DESTINATION/home \
	$DESTINATION/home/home/auditor $DESTINATION/home/public $DESTINATION/home/$DIRNAME
for i in `seq 0 $NCOMPANIES`; do
	FSIZE=`expr $FMINSIZE + $RANDOM % $FVARSIZE`
	if test ${#BANK[@]} -gt $i; then
		COMPANY=${BANK[$i]}
	else
		COMPANY=$COI-$i
	fi
	echo "Creating random confidential file for $COI '$COMPANY' (size $FSIZE) ..."
	dd bs=1 count=$FSIZE if=/dev/urandom of="$DESTINATION/home/$DIRNAME/$COI:$COMPANY:$FILENAME" \
		> /dev/null
done

echo "Creating server configuration files for all servers ..."
for i in `seq $NUMSERVERS`; do
	mkdir -p $DESTINATION/"server$i"
	let PORT=$BASEPORT+$i
	sed -e "s|%%PORT%%|$PORT|" $SOURCE/$PROPFILE | sed -e "s|%%DIR%%|$RUNTIME|" > "$DESTINATION/server$i/$PROPFILE"
done

echo "Done."
