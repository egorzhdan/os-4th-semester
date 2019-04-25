#!/bin/bash

result=()
for pid in $(ps -A -o pid | tail -n +2)
do
  path="/proc/"$pid"/statm"
  diff=$(cat $path 2>/dev/null | awk '{ print $2 - $3 }')
  line=$pid":"$diff
  result+=($pid": "$diff)
done

unsorted=$(printf '%s\n' "${result[@]}")
answer=$(sort --reverse -k2 -n <<< "${unsorted[*]}")
echo "${answer[*]}"
