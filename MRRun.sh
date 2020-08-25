#!/bin/sh
java   -cp ./classes:mr/:lib/commons-math-2.0.jar:lib/ncl-sfc.jar:lib/ncl-taskschedsim.jar:lib/log4j-api-2.11.1.jar:lib/log4j-core-2.11.1.jar net.gripps.cloud.mapreduce.main.MRTest mr.properties
