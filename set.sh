#!/bin/bash
set -e

trap(){
	echo "there is an error"

}  

trap error ERR

echo "HelloWorld"
echo "Before error"
sjhsjhhs
echo "After error"
