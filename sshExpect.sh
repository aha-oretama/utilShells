#!/bin/bash -x

usage () {

cat <<EOT
Usage:
  "$0" -p password username@hostname

Description:
  ssh with password.

Options:
  -p  password

EOT

exit 1
}


while getopts hp: option
do
  case $option in
    p)
      readonly PASSWORD="$OPTARG"
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

shift `expr "$OPTIND" - 1`

if [ -z ${PASSWORD} ]; then
  usage
fi

if [ $# -lt 1 ]; then
  usage
fi


expect -d -c "
set timeout 2
spawn env LANG=C /usr/bin/ssh \"${1}\"
expect \"(yes/no?)\" {
  send \"yes\n\"
  exp_continue
}
expect \"password:\" {
  send \"${PASSWORD}\n\"
}
interact
"
