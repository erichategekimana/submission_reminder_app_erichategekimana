#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo ""
    echo "Checking submissions in $submissions_file"

    echo ""

    printf "%-15s %-20s %-20s\n" "student" "assignment" "submission status"
    echo "---------------------------------------------------------------"

    # Skip the header and iterate through the lines
    tail -n +2 "$submissions_file" | while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            #echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
	    printf "%-15s %-20s %-20s\n" "$student" "$assignment" "$status"
        fi
    done # < <(tail -n +2 "$submissions_file") # Skip the header
    echo ""
    echo ""
}
