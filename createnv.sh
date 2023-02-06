#!/bin/bash

# This script does the following, in this order:
# - check user has given 2-3 arguments; if not, print usage message and exit
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

if [ $# -lt 2 ] || [ $# -gt 3 ] # number of arguments neither 2 nor 3
then
    echo "Usage: ./createnv.sh \`echo \$0\` <name of environment> [<path to parent folder>]"
    echo "If no path is provided, the environment is created in ~/venvs."
    echo "For examples and details, see https://github.com/dsa-ou/virtual-env."
    exit
fi

if [[ $1 == *bash* ]]
then
    shell=bash
elif [[ $1 == *zsh* ]]
then
    shell=zsh
elif [[ $1 == *tcsh* ]]
then
    shell=tcsh
elif [[ $1 == *csh* ]]
then
    shell=csh
elif [[ $1 == *fish* ]]
then
    shell=fish
else
    echo "Unknown shell: $1"
    exit
fi

if [ $# -eq 2 ]
then
    VENV=~/venvs/$2
else
    VENV=$3/$2
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
    echo "alias $2 'source $VENV/bin/activate.csh'" >> ~/.${shell}rc
elif [ $shell = "fish" ]
then
    echo "alias $2='source $VENV/bin/activate.fish'" >> ~/.config/fish/config.fish
else
    echo "alias $2='source $VENV/bin/activate'" >> ~/.${shell}rc
fi
echo "When you next open a terminal, activate the environment by typing $2."
