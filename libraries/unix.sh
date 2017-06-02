#!/usr/bin/env bash
# Error if no option given
if [ -z ${1} ]
then
    echo "No option given execute -h or --help"
    exit
fi

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

# Double check if PPA already exists
function PPA_Exist()
{
    if [ ! -f ${1} ]; then
        ### Add PPA
        sh -c ${2}
    fi
}

function Install_Suite()
{
    # Check user permission for Root
    Permission
    local APT_INSTALL="apt install "
    # refresh PPA lists
    apt update
    # install Suite
    array=${@}
    for i in ${array[@]};
      do
          ${APT_INSTALL}${i}
      done

      echo ${array[@]}
}

