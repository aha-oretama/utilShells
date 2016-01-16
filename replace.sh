#!/bin/sh -x

usage () {

  cat <<EOT
  Usage:
    $0 [-R] [-e] directory|file oldChars newChars

  Description:
    Repalce all occurrences of oldChar in the file or in the files of the directory with newChar.

  Options:
    -R:find files in the directory recursively
    -e:enable regular expression
EOT

exit 1
}

replaceDirectory()
(
  search="$1"
  shift 1
  
  if [ "${search}" = "recursive" ]; then
    for file in `find "$1" -type f`
    do
      replaceFile "${file}" "$2" "$3" "$4"
    done
  else
    for file in "$1"/`ls -F "$1" | grep -v /` 
    do
      replaceFile "${file}" "$2" "$3" "$4"
    done
  fi 
)

replaceFile()
(
  if [ "$4" = "simple" ]; then
    sed -i -e 's/'"$2"'/'"$3"'/g' "$1"
  else
    sed -i -e -G 's/'"$2"'/'"$3"'/g' "$1"
  fi
)

expression="simple"
search="directory"
while getopts Re option
do 
  case $option in
    R)
      search="recursive"
      ;;
    e)
      expresion="regular"
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

if [ $# -lt 3 ]; then
  usage
fi

# ディレクトリのときの処理
if [ -d $1 ]; then
  replaceDirectory "${search}" "$@" "${expression}"
# ファイルのときの処理
elif [ -e $1 ]; then
  replaceFile "$@" "${expression}"
fi

