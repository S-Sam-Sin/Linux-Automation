#!/usr/bin/env bash

function __Clockwork()
{
        YEAR=$(date +%Y)
        MONTH=$(date +%m)
        DAY=$(date +%d)
        HOUR=$(date +%H)
        MINUTE=$(date +%M)
        TIME=$(date +%H:%M)
        SECOND=$(date +%S)
        FULLTIME=$(date +%Y-%m-%d-%H:%M:%S)
}

function __PerceptionOfTime()
{
    __Clockwork
    # ring the bel every hour
    for i in {0..23}
    do
        i="${i}:00"
        if [ ${i} = ${TIME} ]
        then
            # TODO play sound with Gstreamer backend
            echo ${i}
        fi
    done
}