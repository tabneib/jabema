#!/bin/sh
# JaBeMa 1.0
# author: nhd
# chuhoangan@gmail.com

source `dirname $0`/configuration
cwd=`pwd`
# build the server

cd $path_to_impl'server'
ant
mv server-sidechannel.jar $path_to_impl'weaving'

cd $path_to_impl'weaving'




cd $cwd
