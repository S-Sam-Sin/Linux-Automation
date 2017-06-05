#!/usr/bin/env bash

function __SpokenWords()
{
    # Special thanks MARY Web Client voice synthesizer
    # with input text separate words with +
    mpv "http://mary.dfki.de:59125/process?INPUT_TEXT=${1}&INPUT_TYPE=TEXT&OUTPUT_TYPE=AUDIO&AUDIO=WAVE_FILE&LOCALE=en_US&VOICE=dfki-spike-hsmm"
}