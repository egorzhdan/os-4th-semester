#/bin/bash

touch .task5.txt
cur=1
mode="+"

(tail -n 1 -f ".task5.txt") |
while true
do
    read input
    case $input in
        "+")
            mode="+"
            ;;

        "*")
            mode="*"
            ;;

        "QUIT")
            echo "terminated properly"
            exit 0
            ;;

        *)
            if [[ "$input" =~ [0-9]+ ]]
            then
                cur=$(( $cur $mode $input ))
                echo $cur
            else
                echo "terminated: invalid message"
                exit 1
            fi
            ;;
    esac

    sleep 1
done
