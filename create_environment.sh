#!/usr/bin/env bash
# this script will create environment for program that  will be used for reminding students for their assignments
while true; do
	read -p "Enter your name: " usrname
	if [[ ! -d "submission_reminder_$usrname" ]]; then
		parent_dir="submission_reminder_$usrname"
		break
	else
		echo "'$usrname' is arleady taken!"
		echo "Try different one."
		echo " "
	fi
done

mkdir -p "$parent_dir"/{app,modules,asset,config}
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


cat << 'EOF' > "$parent_dir/asset/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
EOF


cat << 'EOF' > "$parent_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF


if [[ ! -f "startup.sh" ]]; then
	cat << 'EOF' > "$parent_dir/startup.sh"
#!/usr/bin/env bash

find . -type f -name "*.sh" -exec chmod +x {} \;

./app/reminder.sh
EOF

fi

chmod +x "$parent_dir/startup.sh"

if [[ ! -d "$parent_dir/app" ]]; then
	echo "Can't find 'app' directory"
fi



echo "Environment setup successful completed at $parent_dir!"
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
echo " "
echo "Done at $TIMESTAMP"
echo " "
echo " "
