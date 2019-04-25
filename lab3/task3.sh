#!/bin/bash

ps -a -o command,pid | grep "^/sbin/" | awk -F ' ' '{ print $2 }' > out3.txt
