#!/usr/bin/env bash

#function __SpokenWords()
#{
#    if [ ${1} = "voice" ]
#    then
#        # Special thanks MARY Web Client voice synthesizer
#        # with input text separate words with +
#        mpv "http://mary.dfki.de:59125/process?INPUT_TEXT=${2}&INPUT_TYPE=TEXT&OUTPUT_TYPE=AUDIO&AUDIO=WAVE_FILE&LOCALE=en_US&VOICE=dfki-spike-hsmm"
#    else
#        mpv /usr/share/sounds/KDE-Im-Phone-Ring.ogg
#    fi
#}

function __SpokenWords()
{
    if [ ${voice} != "off" ]
    then
        mpv ./voice/${voice}/${1}/${2}.ogg
    else
        mpv /usr/share/sounds/KDE-Im-Phone-Ring.ogg
    fi
}