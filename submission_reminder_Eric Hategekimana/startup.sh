#!/usr/bin/env bash

# this will search for all files named with .sh extention, and update their permissions
find . -type f -name "*.sh" -exec chmod +x {} \;

./app/reminder.sh
