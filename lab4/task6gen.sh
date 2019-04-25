#!/bin/bash

while true
do
    read input
    case $input in
        "TERM")
            kill -SIGTERM $(cat .task6.txt)
            exit 0
            ;;

        *)
            continue
            ;;
    esac
done
