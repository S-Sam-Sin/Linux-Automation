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
                # TODO play sound with Gstreamer backend
                echo ${i}
            fi
         done
    fi

    ### workday notifications
    if [ ${workday_notification} ]
    then
        if [ ${TIME} = ${work_begin} -o ${TIME} = ${work_end}  ]
        then
            # TODO play workday notifications sound
            echo ${work_begin}-${work_end}
        elif [ ${TIME} = ${work_lunch} ]
        then
            # TODO play lunch notifications sound
            echo ${work_lunch}
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
            fi
        done
        ### if today is a listed day for shutdown then check the time for shutdown
        if [ ${CHECKTIME} = true -a ${TIME} = ${shutdown_time} ]
        then
            echo "System shutdown is activated"
            shutdown
        fi
    fi
}

# Activate Perception of Time
__PerceptionOfTime