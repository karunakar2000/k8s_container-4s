#!/bin/bash
set -e

trap(){
	echo "there is an error in $LINENO, command is $BASH_COMMAND"

}  

trap error ERR

echo "HelloWorld"
echo "Before error"
sjhsjhhs
echo "After error"
