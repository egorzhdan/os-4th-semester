#/bin/bash

while true
do
    read input
    echo "$input" >> .task5.txt

    if [[ "$input" == "QUIT" ]]
    then
        exit 0
    fi

    if [[ ! "$input" =~ [0-9]+ && "$input" != "+" && "$input" != "*" ]]
    then
        echo "terminated: unknown command: $input"
        exit 1
    fi
done
