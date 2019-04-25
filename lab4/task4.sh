#/bin/bash

./task4helper.sh & pid1=$!
./task4helper.sh & pid2=$!

renice +20 $pid1
top
