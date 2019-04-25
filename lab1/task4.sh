#!/bin/bash

num=1
count=0
while (( ($num % 2) == 1 ))
do
  read num
  ((count++))
done
echo $count
