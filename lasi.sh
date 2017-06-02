#!/usr/bin/env bash
. includes.sh

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

### install Education app suite
elif [ ${1} = "-i" -a ${2} = "-e" ] ||
     [ ${1} = "-i" -a ${2} = "--education" ] ||
     [ ${1} = "--install" -a ${2} = "-e" ] ||
     [ ${1} = "--install" -a ${2} = "--education" ]
then
    # TODO make a collection of education apps
    exit


### install Graphic app suite
elif [ ${1} = "-i" -a ${2} = "-g" ] ||
     [ ${1} = "-i" -a ${2} = "--graphics" ] ||
     [ ${1} = "--install" -a ${2} = "-g" ] ||
     [ ${1} = "--install" -a ${2} = "--graphics" ]
then
    Install_Suite ${CMD_GRAPHICS_KDE[@]}
    exit

### install Internet app suite
elif [ ${1} = "-i" -a ${2} = "-int" ] ||
     [ ${1} = "-i" -a ${2} = "--internet" ] ||
     [ ${1} = "--install" -a ${2} = "-int" ] ||
     [ ${1} = "--install" -a ${2} = "--internet" ]
then
    # TODO make a collection of internet apps
    exit

### install Multimedia app suite
elif [ ${1} = "-i" -a ${2} = "-m" ] ||
     [ ${1} = "-i" -a ${2} = "--multimedia" ] ||
     [ ${1} = "--install" -a ${2} = "-m" ] ||
     [ ${1} = "--install" -a ${2} = "--multimedia" ]
then
    # TODO make a collection of multimedia apps
    exit

### install Utilities app suite
elif [ ${1} = "-i" -a ${2} = "-u" ] ||
     [ ${1} = "-i" -a ${2} = "--utilities" ] ||
     [ ${1} = "--install" -a ${2} = "-u" ] ||
     [ ${1} = "--install" -a ${2} = "--utilities" ]
then
    # TODO create third party app section
    # Dukto PPA
    PPA_Exist ${PPA_DUKTO_LIST} ${PPA_DUKTO_ADD}
    Install_Suite ${CMD_UTILITIES_KDE[@]}
    exit
fi

