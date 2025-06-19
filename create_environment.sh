#!/usr/bin/env bash
# This script, will create environment for program that  will be used to remind students their assignments deadlines


echo " "
sleep 0.7
echo "Welcome to the Submission reminder App!"
echo "This is going to create a directory structure and libraries"
echo "that will be used by application."
echo " "

# this block of code, prompting a user to enter name and use it to create directory named "submission_reminder_{name} and if name is arleady exist, it will print error message, and ask him again
while true; do

	while true; do
		read -rp "Enter your first name: " usrname
		if [[ -z "$usrname" ]]; then
			sleep 0.2
			echo " "
			echo "Error: Name field can not be empty!"
			echo "Please, enter a valid name (e.g: John)"
			echo " "
		else
			break
		fi
	done	

	if [[ ! -d "submission_reminder_$usrname" ]]; then
		parent_dir="submission_reminder_$usrname"
		break
	else
		sleep 0.2
		echo "'$usrname' is arleady taken!"
		echo "Try different one."
		echo " "
	fi
done

sleep 0.3
echo " "
echo "$parent_dir created successfully"
# this will create subdirectories inside $parent_dir
echo "Creating subdirectories..."
sleep 1
mkdir -p "$parent_dir"/{app,modules,asset,config}
echo "Subdirectories successful created"

# heredoc(here document) to create a file named "reminder.sh" and append scripts text onto it immediatery
echo "creating application files and libraries..."
sleep 3



cat << 'EOF' > "$parent_dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions=$submissions_file
EOF


# heredoc(here document) to create a file named "function.sh" and append scripts text onto it immediatery
cat << 'EOF' > "$parent_dir/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF


# heredoc(here document) to create a file named "submission.txt" and append same text onto it immediatery
cat << 'EOF' > "$parent_dir/asset/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
EOF


# heredoc(here document) to create a file named "config.env" and append its scripts onto it immediatery
cat << 'EOF' > "$parent_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

echo "Files created successful!"

# check if we have file named "startup.sh". if it is not present, then create it and add its scripts
if [[ ! -f "$parent_dir/startup.sh" ]]; then # this line means " if there's no file called '$parent_dir/starup.sh'"
	cat << 'EOF' > "$parent_dir/startup.sh"
#!/usr/bin/env bash

# this will search for all files named with .sh extention, and update their permissions
find . -type f -name "*.sh" -exec chmod +x {} \;

./app/reminder.sh
EOF

fi



# give excution permission to "startup.sh"
chmod +x "$parent_dir/startup.sh"
sleep 0.4


echo " "
echo "Environment setup successful completed"
echo "To run this program, use 'startup.sh' file in $parent_dir"
echo "Or simply run 'copilot_shell_scrip.sh'"
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
sleep 0.3
echo ""
echo "Done at $TIMESTAMP"
echo " "
echo " "
