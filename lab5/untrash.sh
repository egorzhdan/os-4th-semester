#/bin/bash

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
trashlog=~/trash.log

if [[ ! -r $trashlog ]]
then
  echo "log must be writeable and readable"
  exit 1
fi

lines=()
mapfile -t lines < $trashlog 2>/dev/null
check "read log"

for line in "${lines[@]}"
do
  original=$(awk '{ print $2 }' <<< $line)
  trashed=$(awk '{ print $4 }' <<< $line)
  name=$(basename $original)
  if [[ "$name" != "$filename" || ! -w $trashed ]]
  then
    continue
  fi
  if [[ -a $original ]]
  then
    echo "skipping" $original "- file already exists"
    continue
  fi

  echo "restore" $original "? [confirm by y]"
  action=""
  read action
  if [[ "$action" == "y" ]]
  then
    ln -- $trashed $original 2>/dev/null

    if (( $? != 0 ))
    then
      echo "failed to restore into initial directory, will restore into home"
      ln -- $trashed ~/$name 2>/dev/null
      check "restore into home"
    fi

    #rm -- $trashed 2>/dev/null
    #check "delete file from trash"
  fi
done
