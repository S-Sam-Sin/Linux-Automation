#!/usr/bin/env bash
. includes.sh

# Error if no option given
if [ -z ${1} ]
then
    echo "No option given execute -h or --help"
    exit
fi

### Help section
if [ ${1} = "-h" ] || [ ${1} = "--help" ]
then
    Help
fi