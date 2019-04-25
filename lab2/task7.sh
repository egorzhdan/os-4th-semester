#!/bin/bash

man bash | tr -c "[:alnum:]" "\n" | grep ".\{4,\}" | sort | uniq -c | sort -nr | head -3
