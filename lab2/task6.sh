#!/bin/bash

ls /var/log/*.log | xargs -n1 cat 2>/dev/null | wc -l
