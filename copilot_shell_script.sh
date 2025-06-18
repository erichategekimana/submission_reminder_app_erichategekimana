#!/usr/bin/env bash
read -r "What is your assignment name?: " new_var

sed -i "s/ASSIGNMENT="Shell Navigation"/ASSIGNMENT=$("$new_var")" "$parent_dir"/config/config.en
