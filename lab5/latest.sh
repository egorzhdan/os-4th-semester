#!/bin/bash

dirs=$(ls -d -t -1 ~/*/ | grep --no-filename --only-matching "Backup[0-9\-]*")

if [[ -z $dirs ]]
then
  echo 1970-01-01
else
  dates=$(sort -r <<< "${dirs[*]}" | head -n 1)
  last_date=$(awk -F '-' '{ print $2 "-" $3 "-" $4 }' <<< ${dates[0]})
  echo $last_date
fi

