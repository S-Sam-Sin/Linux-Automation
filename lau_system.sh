#!/usr/bin/env bash

# Check user permission for Root
function Permission()
{
    # Root user
    local ROOT_UID=0
    # Non root user exit
    local E_NONROOT=87
    # script must be execute as root
    if [ ${UID} != ${ROOT_UID} ]
    then
        echo "The script is not executed as root"
        echo "try using sudo "
        exit
    fi
}

function Install()
{
    local CMD=$(apt install $1) ### install the package
    ${CMD}
}

# Double check if PPA already exists
function PPA_Exist()
{
    if [ ! -f ${1} ]; then
        ### Add PPA
        sh -c ${2}
    fi
}

function Close()
{
    killall -HUP ${1} # Close program
}

function Open()
{
    xdg-open ${1} # File or program
}

function Shutdown()
{
    shutdown ${1} ### give time like
}