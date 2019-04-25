#!/bin/bash

cat /etc/passwd | grep "^[^#]" | awk -F ":" '{ print $3 " - " $1  }'
