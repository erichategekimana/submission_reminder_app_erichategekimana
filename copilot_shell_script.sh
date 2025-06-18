#!/usr/bin/env bash

root_dir=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)

read -rp "Enter the assignment name: " new_var

sed -i "2s|.*|ASSIGNMENT=\"$new_var\"|" "$root_dir/config/config.env"

(cd "$root_dir" && ./startup.sh)
