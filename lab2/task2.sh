#!/bin/bash

log=/var/log/Xorg.0.log
{ grep "\(WW\)" $log & grep "\(II\)" $log; } | sed -e "s/(WW)/Warning:/g" | sed -e "s/(II)/Information:/g" | tee full.log
