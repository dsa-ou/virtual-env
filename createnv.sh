#!/bin/bash

# This script does the following, in this order:
# - check user has given 1-2 arguments; if not, print usage message and exit
# - check terminal is running bash, zsh, tcsh, csh or fish; if not, print error and exit
# - check Python 3.10 is installed; if not, print error and exit
# - check file requirements.txt exists; if not, print error and exit
# - display where environment will be created and ask user to confirm; if not, exit
# - create virtual environment in ~/venvs or in the folder specified by the user
# - activate environment
# - install packages listed in requirements.txt
# - deactivate environment
# - add an alias to shell's startup file
# - tell user they can activate environment by typing its name

if [ $# -lt 1 ] || [ $# -gt 2 ] # number of arguments neither 1 nor 2
then
    echo "Usage: ./createnv.sh <name of environment> [<path to parent folder>]"
    echo "If no path is provided, the environment is created in ~/venvs."
    echo "For examples and details, see https://github.com/dsa-ou/virtual-env."
    exit
fi

parent_shell=$(ps -o command $PPID)

if [[ $parent_shell == *bash* ]]
then
    shell=bash
elif [[ $parent_shell == *zsh* ]]
then
    shell=zsh
elif [[ $parent_shell == *-csh* ]]
then
    shell=tcsh
elif [[ $parent_shell == *-sh* ]]
then
    shell=csh
elif [[ $parent_shell == *fish* ]]
then
    shell=fish
else
    echo "Unknown shell: $1"
    exit
fi

if [ $# -eq 1 ]
then
    VENV=~/venvs/$1
else
    VENV=$2/$1
fi

if ! command -v python3.10 &> /dev/null
then
    echo "Python 3.10 not found: please install it."
    exit
fi

if [ ! -f requirements.txt ]
then
    echo "File requirements.txt not found: please check this is the right folder."
    exit
fi

echo "About to create environment in $VENV"
read -p "Continue? (y/n) " -n 1 -r reply    # read 1 character into variable reply
echo                                        # force a new line after
if [[ $reply =~ ^[Yy]$ ]]                   # reply matches single y or Y
then
    echo "Creating environment... (this will take a bit)"
    python3.10 -m venv $VENV
    echo "Environment created."
else
    exit
fi

source $VENV/bin/activate                   # this script runs under bash
echo "Environment activated."

echo "Dowloading and installing packages... (this will take long)"
pip install --upgrade pip
pip install -r requirements.txt
echo "Packages installed."
deactivate
echo "Environment deactivated."

if [ $shell = "csh" ] || [ $shell = "tcsh" ]
then
    echo "alias $1 'source $VENV/bin/activate.csh'" >> ~/.${shell}rc
elif [ $shell = "fish" ]
then
    echo "alias $1='source $VENV/bin/activate.fish'" >> ~/.config/fish/config.fish
else
    echo "alias $1='source $VENV/bin/activate'" >> ~/.${shell}rc
fi
echo "When you next open a terminal, activate the environment by typing $1."
