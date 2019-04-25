#!/bin/bash

rows=()
for pid in $(ls /proc | grep "^[0-9]")
do
  info=$(cat 2>/dev/null /proc/$pid/status)
  ppid=$(grep "^PPid" <<< $info | tr -d -c '[0-9]')
  sched=$(cat 2>/dev/null /proc/$pid/sched)
  sum_exec_runtime=$(grep "^se.sum_exec_runtime" <<< $sched | tr -d -c '[0-9]')
  nr_switches=$(grep "^nr_switches" <<< $sched | tr -d -c '[0-9]')
  sleepavg=$( awk '{ print $1/$2 }' <<< $sum_exec_runtime" "$nr_switches )
  rows+=($ppid" ProcessID="$pid" : Parent_ProcessID="$ppid" : Average_Sleeping_Time="$sleepavg)
done

unsorted=$(printf '%s\n' "${rows[@]}")
answer=$(sort -k1 -n <<< "${unsorted[*]}")
echo "${answer[@]}" | awk '{ $1="" }1' > out5.txt
