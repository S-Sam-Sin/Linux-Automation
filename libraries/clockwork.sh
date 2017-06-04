#!/usr/bin/env bash

function __Clockwork()
{
        YEAR=$(date +%Y)
        MONTH=$(date +%m)
        DAY=$(date +%u)
        HOUR=$(date +%H)
        MINUTE=$(date +%M)
        TIME=$(date +%H:%M)
        SECOND=$(date +%S)
        FULLTIME=$(date +%Y-%m-%d-%H:%M:%S)
}

function __PlaySound()
{
    mpv /usr/share/sounds/Oxygen-Im-Phone-Ring.ogg
}

function __PerceptionOfTime()
{
    __Clockwork
    ### ring the bel every hour
    if [ ${every_hour_notification} ]
    then
         for i in {0..23}
         do
            i="${i}:00"
            if [ ${i} = ${TIME} ]
            then
                __PlaySound
                break
            fi
         done
    fi

    ### workday notifications
    if [ ${workday_notification} ]
    then
        if [ ${TIME} = ${work_begin} -o ${TIME} = ${work_end}  ]
        then
            __PlaySound
        elif [ ${TIME} = ${work_lunch} ]
        then
            __PlaySound
        fi
    fi

    ### Automatic shutdown
    if [ ${auto_shutdown} ]
    then
        local CHECKTIME=false
        ### loop through al days from the settings.cfg
        for i in ${shutdown_days[@]}
        do
            ### if today is a day listed for shutdown
            if [ ${i} = ${DAY} ]
            then
                CHECKTIME=true
                break
            fi
        done
        ### if today is a listed day for shutdown then check the time for shutdown
        if [ ${CHECKTIME} = true -a ${TIME} = ${shutdown_time} ]
        then
            echo "System shutdown is activated"
            __PlaySound
            shutdown -h now
        fi
    fi
}