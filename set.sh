# #!/bin/bash
# set -e

# error() {
#     echo "there is an error in $LINENO, command is $BASH_COMMAND"
# }  

# trap error ERR

# echo "HelloWorld"
# echo "Before error"
# MegaStar 2>/dev/null   # redirect stderr to /dev/null to hide Bash’s own message
# echo "After error"


#!/bin/bash
set -e

trap 'echo "there is an error in $LINENO, command is $BASH_COMMAND"' ERR

echo "HelloWorld"
echo "Before error"
MegaStar 2>/dev/null   # redirect stderr to /dev/null to hide Bash’s own message
echo "After error"

