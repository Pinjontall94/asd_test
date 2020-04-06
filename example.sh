#!/bin/env sh

# example.sh -- test shell function arguments and returns

ARG1=$1
ARG2=$2
ARG3=$3
RESULT=

argFunc(){
	echo "ARG1 is $ARG1"
	echo "ARG2 is $ARG2"
	echo "ARG3 is $ARG3"
	RESULT=$(( $ARG1 + $ARG2 ))
	return $RESULT
}

argFunc
echo $RESULT
