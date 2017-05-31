#!/usr/bin/env bash

ROOT_UID=0 # Root user
E_NONROOT=87 # Non root user exit
# APT
APT_UPDATE="apt update" # update ppa
APT_REPO="apt-add-repository " # add repo
APT_UPGRADE="apt upgrade" # upgrade packages
APT_INSTALL="apt install " # execute apt
# Office Suite KDE
CMD_OFFICE_KDE="libreoffice libreoffice-style-breeze libreoffice-kde focuswriter kontact kdepim-addons"
CMD_PDF_KDE="okular okular-extra-backends"
# Graphic Suite KDE
CMD_GRAPHICS_KDE="gwenview krita inkscape kruler scribus peruse"
# Utilities Suite KDE
CMD_UTILITIES_KDE="dukto rsibreak kcharselect kcalc synergy ark filelight gufw"

# script must be execute as root
if [ ${UID} != ${ROOT_UID} ]
then
    echo "The script is not executed as root"
    echo "try using sudo"
    exit ${E_NONROOT}
fi

# Error if no option given
if [ -z ${1} ]
then
    echo "No option given execute -h or --help"
    exit ${E_NONROOT}
fi

# Help section
if [ ${1} = "-h" ] || [ ${1} = "--help" ]
then
    echo "lasi 1.0
Usage : lasi.sh [options] [suite]
Made by Sayid Sam-Sin | s_samsin@protonmail.com | https://github.com/S-Sam-Sin/Linux-app-suite-installer

[Description coming soon]

[options]
    -i, --install       install suite
    -r, --remove        remove suite
    -h, --help          give this help list
    -v, --version       print program version

[suite]
    -o, --office        install office app suite
    -g, --graphics      install graphics app suite
    -u, --utilities      install graphics app suite"

# install office app suite
elif [ ${1} = "-i" -a ${2} = "-o" ] ||
     [ ${1} = "-i" -a ${2} = "--office" ] ||
     [ ${1} = "--install" -a ${2} = "-o" ] ||
     [ ${1} = "--install" -a ${2} = "--office" ]
then
    ${APT_UPDATE}
    ${APT_INSTALL}${CMD_OFFICE_KDE}
    ${APT_INSTALL}${CMD_PDF_KDE}
    exit
# install graphic app suite
elif [ ${1} = "-i" -a ${2} = "-g" ] ||
     [ ${1} = "-i" -a ${2} = "--graphics" ] ||
     [ ${1} = "--install" -a ${2} = "-g" ] ||
     [ ${1} = "--install" -a ${2} = "--graphics" ]
then
    ${APT_UPDATE}
    ${APT_INSTALL}${CMD_GRAPHICS_KDE}
    exit
# install Utilities app suite
elif [ ${1} = "-i" -a ${2} = "-u" ] ||
     [ ${1} = "-i" -a ${2} = "--utilities" ] ||
     [ ${1} = "--install" -a ${2} = "-u" ] ||
     [ ${1} = "--install" -a ${2} = "--utilities" ]
then
    ${APT_UPDATE}
    ${APT_INSTALL}${CMD_UTILITIES_KDE}
    exit
fi