#!/bin/sh

usage () {

cat <<EOT
Usage:
  "$0" [-o outputPath] targetFile

Description:
  Unzip file.
  File extension includes .tar .tar.gz .tar.Z .tar.bz2 .zip 

Options:
  -o  output-directory

EOT

exit 1
}

# 出力ファイルパス
OUTPUT_PATH="`pwd`"

while getopts ho: option
do 
  case $option in
    o)
      OUTPUT_PATH="$OPTARG"
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

if [ $# -lt 1 ]; then
  usage
fi

case $1 in
  *.tar)
    tar xvf "$1" -C "$OUTPUT_PATH"
    ;;
  *.tar.gz|*.tar.Z)
    tar zxvf "$1" -C "$OUTPUT_PATH"
    ;;
  *.tar.bz2)
    tar jxvf "$1" -C "$OUTPUT_PATH"
    ;;
  *.zip)
    (CURRENT_DIRECTORY=`pwd`
     cd $OUTPUT_PATH
     unzip "${CURRENT_DIRECTORY}/$1")
    ;;
  *)
    echo "$1"'の拡張子が対応していません
          .tar .tar.gz .tar.Z tar.bz2 .zip' 1>&2
    exit 1;;
esac

