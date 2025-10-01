# #!/bin/bash

set -e

error() {
    echo "there is an error in $LINENO, command is $BASH_COMMAND"
}  

trap error ERR

echo "HelloWorld"
echo "Before error-1"
superstar 2>/dev/null # redirect stderr to /dev/null to hide Bash’s own message
echo "After error-2"
