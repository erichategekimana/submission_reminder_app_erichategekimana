#!/usr/bin/env bash
# prompt user to enter his name

echo ""
echo "Welcome to the copilot!"
echo "Please, make sure that you've created account before you procced"
echo ""
QUIT="q"
COUNTER=0
while true; do
	while true; do

		read -rp "What is your user name: " username
		if [[ -z "$username" ]]; then
			sleep 0.2
			echo "Error: Invalid input!"
			echo "Please, use valid name (e.g: john)"
			echo "or use 'q' to exit the program"
		elif [[ "$username" == "$QUIT" ]]; then
                	echo " "
                	sleep 0.5
                	echo "Aborted by the user "
                	exit 1
        	else
                	break
        	fi
	done


	if [[ ! -d "submission_reminder_$username" ]]; then
		echo "User '$username'not found"
		echo "Try again or type 'q' to exit the program"
		echo ""
	elif [[ "$username" == "$QUIT" ]]; then
        	echo " "
                sleep 0.5
                echo "Aborted by the user "
                exit 1	
	else
		break
	fi
done


# find parent directory of our targeted files and program
root_dir=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)

# prompt user for input, check if it is not empty or if it is 'q' so that program will exit
while true; do
	echo " "
	read -rp "Enter the assignment name: " new_var
	if [[ -z "$new_var" ]]; then
		sleep 0.2
		echo " "
		echo "Error: Invald input!"
		echo "Please, use valid name (e.g: introduction to linux)"
		echo "Use 'q' to exit the program"
		sleep 0.2
	elif [[ "$new_var" == "$QUIT" ]]; then
		echo " "
		sleep 0.5
		echo "Aborted by the user "
		exit 1
	else
		break
	fi
done
echo ""
echo "$new_var selected"

# check if we have $root_dir/config/config.env file
if [[ ! -f "$root_dir/config/config.env" ]]; then
	echo ""
	sleep 0.3
	echo "Error: $root_dir/config/config.env not found"
	echo "Make sure that directory structure is not modified and try again later!"
	echo "Exit..."
	sleep 0.2
	echo ""
	exit 2
fi
# modify the current name in $root_dirconfig/config.env on the 'ASSIGNMENT' value
sed -i "2s|.*|ASSIGNMENT=\"$new_var\"|" "$root_dir/config/config.env"
echo " "
sleep 0.6

# start(run) application
(cd "$root_dir" && ./startup.sh)
echo " "
