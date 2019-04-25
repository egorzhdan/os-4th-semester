#!/bin/bash

grep -r --no-messages --no-filename "^ACPI" /var/log/ | tee errors.log | grep "/[[:alnum:]]+"
