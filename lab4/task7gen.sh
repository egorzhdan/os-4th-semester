#!/bin/bash

pidfile=".task7.txt"
touch $pidfile

while true
do
    read input
    case $input in
        "+")
            kill -USR1 $(cat "$pidfile")
            ;;

        "*")
            kill -USR2 $(cat "$pidfile")
            ;;

        "-")
            kill -WINCH $(cat "$pidfile")
            ;;

        TERM)
            kill -SIGTERM $(cat "$pidfile")
            exit 0
            ;;

        *)
            continue
    esac
done
