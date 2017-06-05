#!/usr/bin/env bash

function __Temperature()
{
        local CMD=$(acpi -t) ### get system temperature
        TEMP=${CMD:14:5} ### substring output so only temperature in Celcius is displayed
}

function __Battery()
{
        local CMD_1=$(acpi -a) ### get if the adapter is on-line
        local CMD_2=$(acpi -b) ### get battery information
        if [ ${CMD_1:10} = "on-line" ]
        then
            AC=true ### battery is charging
        else
            AC=false ### battery is discharging
        fi
        BATTERY=${CMD_2:17} ### battery power in %
}

function PowerManagement()
{
    # Brightness control
    if [ ${1} == "-bc" ]
    then
        qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl org.kde.Solid.PowerManagement.Actions.BrightnessControl.setBrightness ${2}
    fi
}