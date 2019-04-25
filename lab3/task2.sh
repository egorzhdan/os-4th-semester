#!/bin/bash

ps -ef --sort=start_time | awk -v ppid="$$" '{ if ($3!=ppid && $2!=ppid) { print $8" "$2" "$3 } }' | tail -n 1
