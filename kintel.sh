#!/usr/bin/env bash
# Include libraries
. kintel_settings.cfg
. kintel_spokenwords.sh
. kintel_help.sh
. kintel_system.sh
. kintel_power.sh

function __Clockwork()
{
        YEAR=$(date +%Y)
        MONTH=$(date +%m)
        DAY=$(date +%d)
        DATELEADING=$(date +%Y/%m/%d)
        DATE=$(date +%Y/%-m/%-d)
        HOUR=$(date +%H)
        MINUTE=$(date +%M)
        TIME=$(date +%H:%M)
        SECOND=$(date +%S)
        FULLTIME=$(date +%Y-%m-%d-%H:%M:%S)
}

function __Sun()
{
    ### ${SUN} order :
    # sunrise, sunset, transit, civil_twilight_begin, civil_twilight_end,
    # nautical_twilight_begin, nautical_twilight_end,
    # astronomical_twilight_begin, astronomical_twilight_end
    local SUN=$(php ./sun.php "str" ${latitude} ${longtitude})
    local COUNT_START=${1}
    local COUNT_END=6
    ASTRONOMY=${SUN:${COUNT_START}:${COUNT_END}}
}

function __Moon()
{
    local MOON=$(python3 ./moon.py ${1} ${DATE})
    IFS=' ' read -ra MOONINFO <<< "$MOON"

    MOONDATE=${MOONINFO[0]}
    MOONTIME=${MOONINFO[1]:0:5} ### remove seconds
}

function __Astronomy()
{
    local INFO
    # TODO make unique events for different astronomical events
    # TODO play different sounds for each astronomical events
    # TODO reconstruct script to remove duplicate if statements
    case ${1} in
        "sunrise")
            __Sun 0
            if [ ${ASTRONOMY} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
            ;;
        "sunset")
            __Sun 6
            if [ ${ASTRONOMY} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
            ;;
        "full moon")
            __Moon "full"
            if [ ${MOONDATE} = ${DATE} -a ${MOONTIME} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
        ;;
        "new moon")
            __Moon "new"
             if [ ${MOONDATE} = ${DATE} -a ${MOONTIME} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
        ;;
        "first quarter moon")
            __Moon "first_quarter"
             if [ ${MOONDATE} = ${DATE} -a ${MOONTIME} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
        ;;
        "last quarter moon")
            __Moon "last_quarter"
             if [ ${MOONDATE} = ${DATE} -a ${MOONTIME} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
        ;;
        "transit")
            __Sun 12
            if [ ${ASTRONOMY} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
            ;;
        "civil begin")
            __Sun 18
            if [ ${ASTRONOMY} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
            ;;
        "civil end")
            __Sun 24
            if [ ${ASTRONOMY} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
            ;;
        "nautical begin")
            __Sun 30
            if [ ${ASTRONOMY} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
            ;;
        "nautical end")
            __Sun 36
            if [ ${ASTRONOMY} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
            ;;
        "astronomical begin")
            __Sun 42
            if [ ${ASTRONOMY} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
            ;;
        "astronomical end")
            __Sun 48
            if [ ${ASTRONOMY} = ${TIME} ]
            then
                __SpokenWords "no-voice" ""
            fi
            ;;
        esac
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
                __SpokenWords "no-voice" "It+is+${i:0:2}+o'clock"
                break
            fi
         done
    fi

    ### workday notifications
    if [ ${workday_notification} ]
    then
        if [ ${TIME} = ${work_begin} -o ${TIME} = ${work_end}  ]
        then
            __SpokenWords "test"
        elif [ ${TIME} = ${work_lunch} ]
        then
            __SpokenWords "no-voice" "It+is+time+for+some+lunch"
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
             __SpokenWords "no-voice" "System+is+shutting+down"
            shutdown -h now
        fi
    fi
}

# Activate Perception of Time
__PerceptionOfTime
# Activate Astronomy
if [ ${astronomical_notification} ]
then
    __Astronomy "sunrise"
    __Astronomy "sunset"
    __Astronomy "full moon"
    __Astronomy "new moon"
    __Astronomy "first quarter moon"
    __Astronomy "last quarter moon"
    __Astronomy "transit"
    __Astronomy "civil begin"
    __Astronomy "civil end"
    __Astronomy "nautical begin"
    __Astronomy "nautical end"
    __Astronomy "astronomical begin"
    __Astronomy "astronomical end"
else
    echo "Astronomical notification are turned off in kintel_settings.cfg"
fi
