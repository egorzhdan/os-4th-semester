#!/bin/bash

pidfile=".task7.txt"
echo $$ > $pidfile

num=1
mode="wait"

add() {
    mode="add"
}
sub() {
    mode="sub"
}
mul() {
    mode="mul"
}
exit_requested() {
    mode="exit"
}

trap 'add' USR1
trap 'mul' USR2
trap 'sub' WINCH
trap 'exit_requested' SIGTERM

echo $num
while true
do
    case $mode in
        "add")
            (( num+=2 ))
            echo $num
            mode="wait"
            ;;

        "sub")
            (( num-=2 ))
            echo $num
            mode="wait"
            ;;

        "mul")
            (( num*=2 ))
            echo $num
            mode="wait"
            ;;

        "exit")
            echo "terminated: SIGTERM"
            rm $pidfile
            exit 0
    esac

    sleep 1
done
