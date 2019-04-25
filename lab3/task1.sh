#!/bin/bash

ps -u egorzh | tail -n +2 | awk -F ' ' '{ print $1 ":" $4 }' | tee out1.txt | wc -l
