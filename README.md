If you are studying or teaching M269 (starting October 2023 or later),
or if you want to contribute code to `dsa-ou` repositories,
then you will need to install a virtual environment.

Henceforth, any mention of Unix also includes macOS and
`<x>` refers to some information you must type (without the < and >).

## Virtual environments
A virtual environment is a folder with a Python interpreter and additional packages.
This allows us to work on Python projects that have different requirements.
For example, we can have an environment with Python 3.10 and package X 2.0,
and another environment with Python 3.9, package X 1.5 and package Y 2.3.

Virtual environments can be activated and deactivated.
To switch working from project A to project B,
we deactivate the environment used for A and activate the environment for B.

The overall process to create and use a virtual environment for `dsa-ou` is:

- Install Python 3.10 if you don't have it.
- Download the files in this repository.
- Run the script (only for Unix at the moment) that
  creates the environment and installs the packages.
- Activate the created environment.
- Use Python 3.10 and the installed packages.
- Deactivate the environment.

The following instructions provide the details.

## Get Python 3.10
You must first install Python 3.10 if you don't have it.
(You can have multiple Python versions on your computer.)

1. Open a terminal (Unix) or a command prompt (Windows).
2. Type `python3.10 --version` (Unix) or `python3.10.exe --version` (Windows).
3. If you get an error message, download and install [Python 3.10](https://www.python.org/downloads).

There are more extensive instructions for
[macOS](https://docs.python.org/3.10/using/mac.html),
other [Unix platforms](https://docs.python.org/3.10/using/unix.html)
and [Windows](https://docs.python.org/3.10/using/windows.html).

## Get this repository
Next you need a copy of this repository.

4. Click on the green 'Code' button above and select the 'Download ZIP' option.
   This will put an archive with the repository in your downloads folder.
5. Unzip the downloaded archive, if your browser hasn't done so automatically.
   You should now have a `virtual-env-main` folder within the downloads folder.
6. In the terminal or command prompt you opened in step 1, `cd` (change directory)
   to the `virtual-env-main` folder, e.g. type
   `cd ~/Downloads/virtual-env-main` (macOS) or
   `cd C:\Users\me\Downloads\virtual-env-main` (Windows).

## Create and use the environment
Since a virtual environment is a folder, it can be created anywhere on your disk,
with any name. We recommend that you

- keep all your environments inside a folder `venvs` within your home folder
- call the environment `m269-23j` or similar if you're studying or teaching M269 after September 2023
- call the environment `dsa-ou` if otherwise

### In Unix
The steps to create and use virtual environments in Unix are:

7. Create an environment by typing ``./createnv.sh `echo $0` <name>``.

This will create the environment `~/venvs/<name>`. As mentioned above,
`<name>` should be one of `dsa-ou`, `m269-23j`, `m269-24j`, etc.
Note that before `echo` and after the zero are backticks, not quote marks.
If you want to put the environment in a folder other than `~/venvs`, see below.

8.  Close the current terminal and open a new one.
9.  Activate the environment by typing `<name>`
10. Use Python 3.10 and the installed packages
11. Deactivate the environment by typing `deactivate`

Steps 7 and 8 are done once per environment.
Steps 9-11 are done every time you want to use an environment.
The following provides more details on step 7.

The `virtual-env-main` folder has a `createnv` shell script that
first creates an environment of a given name in a given folder
and then installs all necessary packages in that environment.
The script also creates command that allows you to activate the environment
by simply typing its name (step 8).

If the folder doesn't exist, the script creates it for you.

If you don't indicate a folder, the script uses folder `~/venvs`. Some examples:

- ``./createnv.sh `echo $0` m269-23j`` creates the environment in `~/venvs/m269-13j`
- ``./createnv.sh `echo $0` dsa-ou`` creates the environment in `~/venvs/dsa-ou`
- ``./createnv.sh `echo $0` dsa-ou ~/Documents`` creates the environment in `~/Documents/dsa-ou`

After creating an environment, you can't rename it or move it to a different folder:
you must delete that environment
(with `rm -rf ~/venvs/<name>` or `rm -rf <folder>/<name>` if you chose a different folder)
and create a new one with the desired new name and in the desired new folder.

After running the `createnv` script, you can remove folder `virtual-env-main`,
as it's no longer needed.

### In Windows

The steps to create and use virtual environments in Windows are:

_Instructions to be written..._
_Until then you may wish to install Unix under Windows and then proceed as above._

## Unix on Windows
You may wish to install Unix on Windows and do all `dsa-ou` development
(or all study and teaching of M269) in Unix.
Full instructions on how to install Unix in Windows,
including on how to setup Visual Studio Code and git for development,
are on Microsoft's [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) site.

The following simplified instructions are based on a session report
kindly provided by our tutor Andy Connolly.

1. Make sure that
   - you have at least 3Gb free on your disk
   - you are running Windows 10 (version 2004 or higher) or Windows 11.
2. Open a command prompt in administrator mode and enter `wsl --install`.
   This installs Ubuntu and you will need to restart your computer at the end.
   (To install a different Unix distribution, see the full instructions.)
3. Open a command prompt and enter `wsl`. This asks you to create a user name and password.
   The password must be typed twice and doesn't appear on the screen.
4. Once logged in, enter `sudo apt update && sudo apt upgrade`. This will ask you for
   your password and then update your Ubuntu system to the latest version.

That's it! You can now create a virtual environment in your Unix distribution.
Three things you should know:

- To end a Unix session, enter `logout`.
- You can access from Unix your files on Windows. For example,
  file `C:\Users\me\file1.txt` is called `/mnt/c/Users/me/file1.txt` in Unix.
- You can access your Unix files from Windows Explorer, under `//wsl$`.

## Licences

The code and text in this repository are
Copyright © 2023 by The Open University, UK.
The code is licensed under a [BSD-3-clause licence](LICENCE.MD).
The text is licensed under a
[Creative Commons Attribution 4.0 International Licence](http://creativecommons.org/licenses/by/4.0).
