#!/bin/bash

check () {
  if (( $? != 0 ))
  then
    echo "failed to" $1
    exit 1
  fi
}

if (( $# != 1 ))
then
  echo "usage: 1 parameter"
  exit 1
fi

filename=$1
fullpath=$(pwd)/$filename
trashlog=~/trash.log

if [[ -a $trashlog && ! -w $trashlog ]]
then
  echo "log must be writeable"
  exit 1
fi

if [[ ! -w $filename ]]
then
  echo "file must be writable"
  exit 1
fi

if [ ! -d ~/trash ]
then
  mkdir ~/trash 2>/dev/null
  check "create trash directory"
fi

uuid=$(cat /proc/sys/kernel/random/uuid)
trashfile=~/trash/$uuid
ln -- $fullpath $trashfile 2>/dev/null
check "move to trash"

rm -- $filename 2>/dev/null
check "remove original file"

touch $trashlog 2>/dev/null
check "create log if missing"

echo "removed $fullpath into $trashfile" >> $trashlog
