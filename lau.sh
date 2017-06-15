#!/usr/bin/env bash
# Include libraries
. lau_settings.cfg
. lau_spokenwords.sh
. lau_help.sh
. lau_system.sh
. lau_power.sh


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

function __Bell()
{
    ### ring the bel every hour
    for i in {0..23}
    do
        i="${i}:00"
        if [ ${i} = ${TIME} ]
        then
            __SpokenWords "off" "It+is+${i:0:2}+o'clock"
            break
        fi
    done
}

function __WorkDay()
{
    ### workday notifications
    if [ ${TIME} = ${work_begin} -o ${TIME} = ${work_end}  ]
    then
         __SpokenWords "off"
    elif [ ${TIME} = ${work_lunch} ]
    then
        __SpokenWords "off" "It+is+time+for+some+lunch"
    fi
}

function __Rest()
{
    ### Automatic shutdown
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
        __SpokenWords "off" "System+is+shutting+down"
        shutdown -h now
    fi
}

function __Sun()
{
    ### ${SUN} order :
    # sunrise, sunset, transit, civil_twilight_begin, civil_twilight_end,
    # nautical_twilight_begin, nautical_twilight_end,
    # astronomical_twilight_begin, astronomical_twilight_end
    local SUN=$(php ./sun.php "str" ${latitude} ${longtitude})
    IFS=' ' read -ra SUNINFO <<< "$SUN"
    echo ${SUNINFO}
    for i in ${SUNINFO[@]}
    do
        if [ ${i} = ${TIME} ]
        then
            __SpokenWords "sun" ${1}
            break
        fi
    done
}

function __Moon()
{
    local MOON=$(python3 ./moon.py ${1} ${DATE})
    IFS=' ' read -ra MOONINFO <<< "$MOON"

    MOONDATE=${MOONINFO[0]}
    MOONTIME=${MOONINFO[1]:0:5} ### remove seconds

    if [ ${MOONDATE} = ${DATE} -a ${MOONTIME} = ${TIME} ]
    then
        __SpokenWords "moon" ${1}
    fi
}


if [ ${every_hour_notification} ]
then
    __Bell
fi

if [ ${workday_notification} ]
then
    __WorkDay
fi

# Activate Astronomy
if [ ${astronomical_notification} ]
then
    __Sun
    __Moon "full"
    __Moon "new"
    __Moon "first_quarter"
    __Moon "last_quarter"
else
    echo "Astronomical notification are turned off in lau_settings.cfg"
fi

if [ ${auto_shutdown} ]
then
    __Rest
fi