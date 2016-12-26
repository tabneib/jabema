#!/bin/bash

source `dirname $0`/configuration

echo "# General configuration"
echo "# The number of units listed below should be the same as configured below as numberOfUnits"
echo "#cfg.units   = id-1," 
echo "cfg.units   = id-1"
echo "#cfg.units   = id-1, id-2, id-3, id-4, id-5, id-6, id-7, id-8, id-9, id-10"
echo "#cfg.destdir = /tmp/server-sidechannel"
echo "cfg.destdir = "$path_to_build"encap-server"

echo "# Default unit configuration"
echo "unit.type                 = Java"
echo "unit.target               = target/server-sidechannel.jar"
echo "unit.target-javavm        = /usr/bin/java"
echo "unit.pointcuts            = target/server-sidechannel.pc"
echo "unit.policy               = bucketing.Bucketing"
echo "unit.policy.numberOfUnits = 1"
echo "unit.event-factory        = bucketing.BucketingEventFactory"
echo "unit.enforcer-factory     = bucketing.BucketingEnforcerFactory"
echo "#unit.inline-classpath     = "$path_to_utils_encapsulation"server-sidechannel-Bucketing.jar:std-enforcers:log4j:jansi"
echo "unit.inline-classpath     = "$path_to_utils_encapsulation"bucketing/server-sidechannel-Bucketing.jar:std-enforcers:jansi"

echo "#unit.policy-classpath     = "$path_to_utils_encapsulation"bucketing/server-sidechannel-Bucketing.jar:log4j"
echo "unit.policy-classpath     = "$path_to_utils_encapsulation"bucketing/server-sidechannel-Bucketing.jar"
echo "#unit.loglevel            = INFO"
echo "unit.loglevel             = INFO"

echo "# NOTE:"
echo "# This configuration file does not include any connectivity configuration."
echo "# For connectivity configurations, check the network-*.cfg files in the"
echo "# very same directory."
