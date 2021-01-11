#!/bin/bash
# **************************************************
# (C) Rackspace 2021, fabian.salamanca@rackspace.com
# **************************************************

if [ $# -lt 1 ]; then
	echo "Uso: $0 <archivo.robot>"
	exit 1
fi

TEST=$1

source robot/bin/activate

pip install -r requirements.txt

robot $TEST

deactivate
