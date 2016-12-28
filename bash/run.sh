#!/bin/bash
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com

source `dirname $0`/configuration
cwd=`pwd`

invalid () {
	echo -e "Invalid arguments!"
	#echo -e "\t./run server [c|i]"
	echo -e "\t./run client [c|i] [0|1|2|3] [#invocations]"
}

invoke_server_c () {
	echo "|-----------------------|"
	echo -e "|\tSERVER\t\t|"
	echo "|-----------------------|"

	#javac ./de.tud.mais.hiwi.server/src/serversidechannel/*.java
	# Server - Compiler
	# $1: Param
	# $2: port
	# $3: Id of the current sample
	# java -Xmx2000m -cp ./de.tud.mais.hiwi.server/src serversidechannel.main "$1" "$2" "$path_output" "$measurements" "$3" &
	java -Xmx2000m -jar "$path_to_build"encap-server/id-1/JavaStarter.jar "$1" "$2" "$path_to_tmp_output" "$measurements" "$3" &
}

invoke_client_i () {
	#####################################################
	#######  NOT USED FOR NOW !!
	#####################################################
	if [ $2 -ge 0 ] && [ $2 -le 3 ]; then
		for (( c = 1; c <= $1; c++ ))
		do
			#./run server c $($c + 1111) &
			# Server - Compiler
			port=`expr $c + $init_port`
			invoke_server_c $2 $port $c
			sleep 0.1
			# Client - Interpreter
			echo "Client - Interpreter - MAC: $2 - Sample: $c" 
			java -jar -Xint $path_to_impl'client/client-sidechannel.jar' "$2" $c $port "$measurements"
		done
	else			
		invalid
	fi
}



# $1: samples
# $2: MAC value
invoke_client_c () {
	#####################################################
	#######  Hard coded !!
	#####################################################
	if [ $2 -ge 0 ] && [ $2 -le 3 ]; then
		for (( c = 1; c <= $1; c++ ))
		do
			#./run server c $($c + 1111) &
			# Server - Compiler
			port=`expr $c + $init_port`
			# arguments: MAC value - port - iter counter
			invoke_server_c $2 $port $c
			sleep 0.7			
			# Client - Compiler
			echo "Client - Compiler - MAC: $2 - Sample: $c"
			java -jar $path_to_impl'client/client-sidechannel.jar' "$2" $c $port "$measurements"
			sleep 0.7
		done
	else		
		# invalid MAC value	
		invalid
	fi
}




# compile the client and server source code 
#javac ./de.tud.mais.hiwi.server/src/serversidechannel/*.java
#javac ./de.tud.mais.hiwi.client/src/client/*.java


if [ "$1" = "server" ]; then
	
	#####################################################
	#######  DEPRECATED !!
	#####################################################
	echo "|-----------------------|"
	echo -e "|\tSERVER\t\t|"
	echo "|-----------------------|"

	#javac ./de.tud.mais.hiwi.server/src/serversidechannel/*.java

	if [ "$2" = "c" ]; then
		# Server - Compiler
		#java -cp ./de.tud.mais.hiwi.server/src serversidechannel.main "$3"
		java -jar $path_to_impl'server/server-sidechannel.jar' '$3'
	else
		if [ "$2" = "i" ]; then
			# Server - Interpreter
			#java -Xint -cp ./de.tud.mais.hiwi.server/src serversidechannel.main "$3"	
			java -jar $path_to_impl'server/server-sidechannel.jar' '$3'
		else
			invalid
		fi
	fi

else
 	if [ "$1" = "client" ]; then
		echo "|-----------------------|"
		echo -e "|\tCLIENT\t\t|"
		echo "|-----------------------|"
		
		# $3: MAC value 
		# $4: samples (can also be read from configuration)
		if [ "$2" = "c"  ] && [ ! -z "$4" ]; then
			invoke_client_c $4 $3
		else
			if [ "$2" = "i" ] && [ ! -z "$4" ]; then
				invoke_client_i $4 $3
			else
				invalid
			fi
		fi
	else
		invalid
	fi
fi

cd $cwd
