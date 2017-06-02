#!/usr/bin/env bash

. includes.sh

function Help()
{
    echo "lasi 1.0
Usage : lasi.sh [options] [suite]
Made by Sayid Sam-Sin | s_samsin@protonmail.com | https://github.com/S-Sam-Sin/Linux-app-suite-installer

[Description coming soon]

[options]
    -i, --install       install suite
    -h, --help          give this help list

[suite]
    -d, --development   install development app suite
    -o, --office        install office app suite
    -g, --graphics      install graphics app suite
    -u, --utilities     install graphics app suite"
}

### Help section
if [ ${1} = "-h" ] || [ ${1} = "--help" ]
then
    Help
### install office app suite
elif [ ${1} = "-i" -a ${2} = "-o" ] ||
     [ ${1} = "-i" -a ${2} = "--office" ] ||
     [ ${1} = "--install" -a ${2} = "-o" ] ||
     [ ${1} = "--install" -a ${2} = "--office" ]
then
    Install_Suite ${CMD_OFFICE_KDE[@]}
    exit

### install Development app suite
elif [ ${1} = "-i" -a ${2} = "-d" ] ||
     [ ${1} = "-i" -a ${2} = "--development" ] ||
     [ ${1} = "--install" -a ${2} = "-d" ] ||
     [ ${1} = "--install" -a ${2} = "--development" ]
then
    Install_Suite ${CMD_DEV_KDE[@]}
    exit


### install Graphic app suite
elif [ ${1} = "-i" -a ${2} = "-g" ] ||
     [ ${1} = "-i" -a ${2} = "--graphics" ] ||
     [ ${1} = "--install" -a ${2} = "-g" ] ||
     [ ${1} = "--install" -a ${2} = "--graphics" ]
then
    Install_Suite ${CMD_GRAPHICS_KDE[@]}
    exit

### install Utilities app suite
elif [ ${1} = "-i" -a ${2} = "-u" ] ||
     [ ${1} = "-i" -a ${2} = "--utilities" ] ||
     [ ${1} = "--install" -a ${2} = "-u" ] ||
     [ ${1} = "--install" -a ${2} = "--utilities" ]
then
    # Dukto PPA
    PPA_Exist ${PPA_DUKTO_LIST} ${PPA_DUKTO_ADD}
    Install_Suite ${CMD_UTILITIES_KDE[@]}
    exit
fi