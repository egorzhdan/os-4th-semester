#!/bin/bash

echo "Menu:"
echo "1. open nano"
echo "2. open vi"
echo "3. open links"
echo "4. exit"

opt=0
read opt
case $opt in
1) nano ;;
2) vi ;;
3) links ;;
*) exit 0 ;;
esac
