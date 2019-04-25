#!/bin/bash

check () {
  if (( $? != 0 ))
  then
    echo "failed to" $1
    exit 1
  fi
}

restoredir=~/restore
last_date=$(./latest.sh)
backupdir=~/Backup-$last_date/
echo restoring from $backupdir

if [[ ! -d $backupdir ]]
then
  echo "backup not found"
  exit 1
fi

shopt -s globstar
for file in $backupdir**
do
  rel=$(realpath --relative-to=$backupdir $file)
  restorefile=$restoredir/$rel

  if [[ ! -d $file ]]
  then
    regex="\.[0-9]{4}-[0-9]{2}-[0-9]{2}$"
    if [[ ! ( $file =~ $regex ) ]]
    then
      cp -- $file $restorefile 2>/dev/null
      check "copy file into restore directory: $file"
      echo restored into $restorefile
    fi
  else
    mkdir -p -- $restorefile 2>/dev/null
    check "create intermediate directory: $restorefile"
  fi
done

