#!/usr/bin/env bash
# welcome messages
echo ""
sleep 0.5
echo "Welcome to the copilot!"
sleep 0.7
echo "Please, make sure that you've created account before you proceed"
echo "The name used to create application environment"
echo "is your user name."
echo ""

# prompt user to enter his name
QUIT="q"
while true; do
	while true; do

		read -ep "What is your user name: " username
		if [[ -z "$username" ]]; then # if user input is zero(empty)
			sleep 0.5
			echo ""
			sleep 0.2
			echo "Error: Invalid input!"
			echo "Please, use valid name (e.g: john)"
			echo "or use 'q' to exit the program"
			echo ""
		elif [[ "$username" == "$QUIT" ]]; then # if user input is equal to 'q', exit 
                	echo " "
                	sleep 0.5
                	echo "Aborted by the user "
                	exit 1
        	else
                	break
        	fi
	done


	if [[ ! -d "submission_reminder_$username" ]]; then # check for correctness. if it doesn't march, repeat loop
		echo ""
		sleep 0.5
		echo "User '$username' not found"
		echo "User name, is a name used when you created application environment."
		echo "Please create your account first using 'create_environment.sh'"
		echo ""
		echo "Try again Or type 'q' to exit the program"
		echo ""
	elif [[ "$username" == "$QUIT" ]]; then # use 'q' to exit
        	echo " "
                sleep 0.5
                echo "Aborted by the user "
                exit 1	
	else
		break
	fi
done


# set variable for parent directory of our targeted files and program
root_dir="submission_reminder_$username"

echo ""
sleep 1
echo "Welcome $username!"
echo ""
echo "Assignment list: "
echo "1. Shell Navigation"
echo "2. Shell Basics"
echo "3. Git"
echo "4. Introduction To Linux"
echo "5. Shell Permission Control"


# prompt user for input, check if it is not empty or if it is 'q' so that program will exit
while true; do
	echo " "
	read -ep "Enter the assignment name: " new_var
	if [[ -z "$new_var" ]]; then # if input is empty
		sleep 0.2
		echo " "
		echo "Error: Invald input!"
		echo "Please, use valid name (e.g: Introduction To Linux)"
		echo "Use 'q' to exit the program"
		sleep 0.2
	elif [[ "$new_var" == "$QUIT" ]]; then # if input is 'q'
		echo " "
		sleep 0.5
		echo "Aborted by the user "
		exit 1

		# if input march one of the valid assignment, break this while loop
	elif [[ "$new_var" == "Shell Navigation" ]]; then
		break
	elif [[ "$new_var" == "Shell Basics" ]]; then
                break
	 elif [[ "$new_var" == "Git" ]]; then
                break
	 elif [[ "$new_var" == "Introduction To Linux" ]]; then
                break
	 elif [[ "$new_var" == "Shell Permission Control" ]]; then
                break
	else
		sleep 0.5
		echo "Assignment '$new_var' not found. Try again"
		echo "Please, use the list provided to navigate valid assignment name."
		echo "or use 'q' to exit the program"
		echo ""
		echo "Note: This application is case sensitive!"
	fi
done
sleep 0.7
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
# modify the current name in $root_dir/config/config.env on the 'ASSIGNMENT' value
sed -i "2s|.*|ASSIGNMENT=\"$new_var\"|" "$root_dir/config/config.env"
echo " "
sleep 0.6

# start(run) application
cd "$root_dir" || exit
./startup.sh
echo " "
