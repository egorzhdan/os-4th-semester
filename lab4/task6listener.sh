#!/bin/bash

echo $$ > .task6.txt

count=0
mode="work"

exit_requested() {
    mode="stop"
}
trap 'exit_requested' SIGTERM

while true
do
    case $mode in
        "work")
            (( count++ ))
            echo $count
            ;;

        "stop")
            echo "terminated: SIGTERM"
            rm .task6.txt
            exit 0
    esac

    sleep 1
done
