#!/bin/bash

lines=$()
mapfile -t lines < out5.txt

cur_ppid=-1
sleep_avg=0
sleep_cnt=0
for ((i = 0; i < ${#lines[@]}; i++))
do
  echo "${lines[$i]}"
  ppid=$( echo "${lines[$i]}" | awk '{ print $3 }' | tr -d -c '[0-9]' )
  cur_sleep=$( echo "${lines[$i]}" | awk '{ print $5 }' | tr -d -c '[0-9]' )
  sleep_avg=$(( sleep_avg + cur_sleep ))
  sleep_cnt=$(( sleep_cnt + 1 ))

  if (( cur_ppid != ppid ))
  then
    if (( cur_ppid != -1 ))
    then
      avg=$( awk '{ print $1/$2 }' <<< $sleep_avg" "$sleep_cnt )
      echo "Average_Sleeping_Children_of_ParentID="$ppid" is "$avg
      sleep_avg=0
    fi
    cur_ppid=$ppid
  fi
done
