#!/bin/bash

# Script for changing Numix base folder style

# Copyright (C) 2014
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License (version 3+) as
# published by the Free Software Foundation. You should have received
# a copy of the GNU General Public License along with this program.
# If not, see <http://www.gnu.org/licenses/>.

version="0.4.2"

# Allows timeout when launched vai 'Run in Terminal'
function gerror() { sleep 3; exit 1; }

if [ -z "$1" ]
then
    :
else
    case "$1" in
        -l|--list)
            echo -e \
                "This is a list of currently supported folder\n" \
                "\rstyles that can be used to replace the default.\n\n" \
                "\r0 - default folder theme (uninstall)\n" \
                "\r1 - original folders that came with circle\n" \
                "\r2 - 1 with the colour scheme from 0\n" \
                "\r3 - new foler design with vibrant colours\n" \
                "\r4 - 3 with the colour scheme from 1"
            exit 0 ;;
        -h|--help)
            echo -e \
                "Usage: ./$(basename -- $0) [OPTION]\n" \
                "\rScript for changing Numix base folder style.\n\n" \
                "\rRunning as root makes the change globally,\n" \
                "\rotherwise it is only made locally. Run as\n" \
                "\rappropriate to your Numix installation.\n\n" \
                "\rCurrently supported options:\n" \
                "\r  -l, --list \t\t List of available styles.\n" \
                "\r  -h, --help \t\t Displays this help menu.\n" \
                "\r  -v, --version \t Displays program version."
            exit 0 ;;
        -v|--version)
            echo -e "$(basename -- $0) $version\n"
            exit 0 ;;
        *)
            echo -e \
                "$(basename -- $0): invalid option -- '$1'\n" \
                "\rTry '$(basename -- $0) --help' for more information."
            gerror ;;
    esac
fi

read -p "Which folder style do you want? " answer
if [ -d files/"$answer" ]; then
    style="$answer"
else
    echo -e \
        "Please choose a valid style number Run\n" \
        "\r'$(basename) --list' for a complete list"
    gerror
fi

if [[ $UID -ne 0 ]]
then

    if [ -d /home/"${SUDO_USER:-$USER}"/.local/share/icons/Numix/ ]
    then
        cp -av files/"${style}"/* /home/"${SUDO_USER:-$USER}"/.local/share/icons/Numix/ && \
        echo -e "\n\nDONE.\n"
    elif [ -d /home/"${SUDO_USER:-$USER}"/.icons/Numix ]
    then
        cp -av files/"${style}"/* /home/"${SUDO_USER:-$USER}"/.icons/Numix/ && \
        echo -e "\n\nDONE.\n"
    else
        echo "Use \"sudo $0\" because you don't appear to have Numix installed locally."
        gerror
    fi
else
    if [ -d "/usr/share/icons/Numix/" ]
    then
        cp -av files/"${style}"/* /usr/share/icons/Numix/ && \
        echo -e "\n\nDONE.\n"
    else
        echo "You don't appear to have Numix installed globally."
        gerror
    fi

fi
