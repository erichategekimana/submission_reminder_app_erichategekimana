# Submission Reminder App

Hi there!
It's Good to see you :)

This README file is going to take you through how this project is done and how it works
so that you can understand how it works or contribute too. you can contribute by modifying files (request permission) or give an ideas of what to improve by commenting or contacting use.

lets go...!

This is a shell project I built that helps track which students haven’t submitted their assignments yet. The app is lightweight and runs in the terminal. It uses basic shell scripting logic, file parsing, and simple automation.

---

## Project Structure

When the environment is created, it looks like this:


submission_reminder_<yourname>/
├── app/
│ └── reminder.sh
├── modules/
│ └── functions.sh
├── assets/
│ └── submissions.txt
├── config/
│ └── config.env
└── startup.sh



Each file and folder plays a role in the logic of reminding students based on assignment submission status.

---

## Scripts

### `create_environment.sh`

This script sets up the whole environment for the app. It:
- Prompts for your name
- Creates a directory called `submission_reminder_<yourname>`
- Populates all necessary subdirectories and files
- Gives execute permissions to all `.sh` files
- Adds some student records to get started



Each file and folder plays a role in the logic of reminding students based on assignment submission status.

---

## Scripts

### `create_environment.sh`

This script sets up the whole environment for the app. It:
- Prompts for your name
- Creates a directory called `submission_reminder_<yourname>`
- Populates all necessary subdirectories and files
- Gives execute permissions to all `.sh` files
- Adds some student records to get started



Each file and folder plays a role in the logic of reminding students based on assignment submission status.

---

## Scripts

### `create_environment.sh`

This script sets up the whole environment for the app. It:
- Prompts for your name
- Creates a directory called `submission_reminder_<yourname>`
- Populates all necessary subdirectories and files
- Gives execute permissions to all `.sh` files
- Adds some student records to get started

Run this first:

bash create_environment.sh or simply do ./create_envirnment.sh




startup.sh(you can find it in submission_reminder_*/startup.sh)

This script runs the actual reminder logic. It:
Note: make sure that you're in root directory when you run this script. otherwise, use copilot_shell_script.sh

Reads the current assignment from config/config.env

Checks assets/submissions.txt

Prints a list of students who have not submitted that assignment



copilot_shell_script.sh
This script lets you change the current assignment dynamically. It:
1. it first ask you your user name(this is name used when you created you envvironment )
Prompts for a new assignment name(list is provided, so you have to select one of it)
not: this app is case sensitive! so you better be careful
Updates config.env with the new name

Re-runs startup.sh so you can immediately see updated results


This is how It Works:

config/config.env holds the current assignment name

assets/submissions.txt contains the student data in this format:


student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted

And then the scripts filter and display students who haven’t submitted the assignment listed in config.env


Here is an example of Output

student         assignment           submission status
---------------------------------------------------------------
Chinemerem      Shell Navigation     not submitted
Divine          Shell Navigation     not submitted



Notes
The scripts handle assignment names with spaces (like intro to linux)

Paths are managed carefully, but if you move things around, you might need to fix them

functions.sh holds reusable logic like file reading and parsing

You can quit the copilot or creating script by typing q


you may wonder why I Did This!

Here is why:

I built this to practice shell scripting — reading files, using functions, handling input/output, working with sed, read, source, and more. It helped me improve my skills and understand how scripting can solve real tasks like managing student submissions.

Thank you!
