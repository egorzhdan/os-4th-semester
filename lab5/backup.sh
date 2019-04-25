#!/bin/bash

check () {
  if (( $? != 0 ))
  then
    echo "failed to" $1
    exit 1
  fi
}

curdate=$(date +%Y-%m-%d)
last_date=$(./latest.sh)
diff=$(( ( - $(date '+%s' --date="$last_date") + $(date '+%s' --date="$curdate")) / 86400 ))
echo "last backup is" $last_date "-" $diff "days ago"

sourcedir=~/source/
curdir=""
report=~/backup-report

if [[ -a $report && ! -w $report ]]
then
  echo "report must be writeable"
  exit 1
fi
if [[ ! -r $sourcedir ]]
then
  echo "source directory must be readable"
  exit 1
fi

if (( $diff > 7 ))
then
  curdir=~/Backup-$curdate
  mkdir -- $curdir 2>/dev/null
  check "create directory for new backup"
  echo "created new:" $curdir >> $report

  cp -R -- $sourcedir. $curdir 2>/dev/null
  check "copy files into new backup"

  ls -l -- $curdir >> $report
else
  curdir=~/Backup-$last_date

  added=()
  overridden=()
  ignored=()

  shopt -s globstar
  for file in $sourcedir**
  do
    rel=$(realpath --relative-to=$sourcedir $file)
    backupfile=$curdir/$rel

    if [[ ! -d $file ]]
    then
      if [[ ! -f $backupfile ]]
      then
        cp -- $file $backupfile
        check "copy file" $file
        echo copied $file to $backupfile
        added+=("$backupfile")
      elif (( $(stat --printf="%s" $backupfile) == $(stat --printf="%s" $file) ))
      then
        ignored+=("$backupfile")
        echo ignoring: equal size $file and $backupfile
      else
        mv -- $backupfile $backupfile.$curdate
        check "handle file collision"
        cp -- $file $backupfile
        echo different size $file and $backupfile
        overridden+=("$backupfile;$backupfile.$curdate")
      fi
    else
      mkdir -p -- $backupfile
    fi
  done

  echo "===============" >> $report
  echo "finished backup on $curdate: $curdir" >> $report

  printf 'ADDED %s\n' "${added[@]}" >> $report
  printf 'IGNORED %s\n' "${ignored[@]}" >> $report
  printf 'OVERRIDDEN %s\n' "${overridden[@]}" >> $report
fi

