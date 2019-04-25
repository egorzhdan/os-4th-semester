#!/bin/bash

grep -r --only-matching --no-filename --no-messages "^[A-Za-z0-9\.]\+@[A-Za-z0-9\.]\+$" /etc/ | sort | uniq -u > emails.lst

