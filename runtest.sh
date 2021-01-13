#!/bin/bash
# **************************************************
# (C) Rackspace 2021, fabian.salamanca@rackspace.com
# **************************************************

if [ $# -lt 1 ]; then
	echo "Uso: $0 <archivo.robot>"
	exit 1
fi

TEST=$1

source /apitest/robot/bin/activate

robot $TEST

deactivate
