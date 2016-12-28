#!/bin/bash
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com

source `dirname $0`/configuration
cwd=`pwd`

# Generate the CliSeAu configuration file
$path_to_bash'gen_cfg' > $path_to_utils_encapsulation'ServerSideChannel-Bucketing.cfg'

build_server () {

	echo -e "\n=============== Building Server ===============\n"
	# assume that we are in the Server-SideChannel directory
	cd $path_to_impl'server'
	ant
	mv server-sidechannel.jar $path_to_utils_encapsulation'target/'
}

build_enforcer () {
	echo -e "\n========= Building Policy and Enforcer =========\n"
	cd $path_to_utils_encapsulation'bucketing'
	#javac bucketing/*.java -classpath "$path_project_code"Server-SideChannel/CliSeAu-20141008/build/CliSeAuRT.jar:"$path_project_code"Server-SideChannel/target/server-sidechannel.jar -sourcepath .

	#jar cvf server-sidechannel-Bucketing.jar bucketing/*.class
	ant
	#mv server-sidechannel-Bucketing.jar ../
	
}

encapsulate () {
	
	cd $path_to_utils_encapsulation'CliSeAu-20141008'
	echo -e "\n================= Encapsulating =================\n"
	# build CliSeAu
	ant
	java -jar build/encaps.jar $path_to_utils_encapsulation'ServerSideChannel-Bucketing.cfg' tests/network-local.cfg
}

run () {
	# start
	echo -e "\n========= Triggering Encapsulated Server =========\n"
	java -jar "$path_to_build"encap-server/id-1/JavaStarter.jar

}



if [ $# -eq 0 ]; then
	
	build_server
	build_enforcer
	encapsulate
	cd $cwd
	

else
	if [ $# -eq 1 ] && [ "$1" == "run" ]; then
		#cd Server-SideChannel
		run
	else
		if [ "$1" == "all" ]; then
			#cd "$path_project_code"Server-SideChannel
			build_server
			build_enforcer
			encapsulate	
			cd ..
			run
		else
			echo "Wrong arguments!"
		fi
	fi
fi
