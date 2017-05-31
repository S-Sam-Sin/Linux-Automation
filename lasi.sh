#!/usr/bin/env bash

# Check user permission for Root
function Permission()
{
    # Root user
    local ROOT_UID=0
    # Non root user exit
    local E_NONROOT=87
    # script must be execute as root
    if [ ${UID} != ${ROOT_UID} ]
    then
        echo "The script is not executed as root"
        echo "try using sudo"
        exit ${E_NONROOT}
    fi
}

# Double check if PPA already exists
function PPA_Exist()
{
    if [ ! -f ${1} ]; then
        ### Add PPA
        sh -c ${2}
    fi
}

function Install_Suite()
{
    # Check user permission for Root
    Permission
    local APT_INSTALL="apt install "
    # refresh PPA lists
    apt update
    # install Suite
    array=${@}
    for i in ${array[@]};
      do
          ${APT_INSTALL}${i}
      done

      echo ${array[@]}
}

function Help()
{
    echo "lasi 1.0
Usage : lasi.sh [options] [suite]
Made by Sayid Sam-Sin | s_samsin@protonmail.com | https://github.com/S-Sam-Sin/Linux-app-suite-installer

[Description coming soon]

[options]
    -i, --install       install suite
    -h, --help          give this help list

[suite]
    -d, --development   install development app suite
    -o, --office        install office app suite
    -g, --graphics      install graphics app suite
    -u, --utilities     install graphics app suite"
}


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
### install office app suite
elif [ ${1} = "-i" -a ${2} = "-o" ] ||
     [ ${1} = "-i" -a ${2} = "--office" ] ||
     [ ${1} = "--install" -a ${2} = "-o" ] ||
     [ ${1} = "--install" -a ${2} = "--office" ]
then
    declare -a CMD_OFFICE_KDE=('libreoffice' 'libreoffice-style-breeze' 'libreoffice-kde' 'focuswriter' 'kontact' 'kdepim-addons' 'okular' 'okular-extra-backends')
    Install_Suite ${CMD_OFFICE_KDE[@]}
    # Download Master PDF Editor 4 Free
    cd ~/Downloads/
    wget http://get.code-industry.net/public/master-pdf-editor-4.1.30_qt5.amd64.deb
    dpkg -i ./master-pdf-editor-4.1.30_qt5.amd64.deb
    rm ./master-pdf-editor-4.1.30_qt5.amd64.deb
    exit

### install Development app suite
elif [ ${1} = "-i" -a ${2} = "-d" ] ||
     [ ${1} = "-i" -a ${2} = "--development" ] ||
     [ ${1} = "--install" -a ${2} = "-d" ] ||
     [ ${1} = "--install" -a ${2} = "--development" ]
then
    declare -a CMD_DEV_KDE=('kdevelop' 'kdevelop-python' 'kdevelop-php' 'mysql-workbench' 'phpmyadmin' 'qtcreator')
    Install_Suite ${CMD_DEV_KDE[@]}
    exit


### install Graphic app suite
elif [ ${1} = "-i" -a ${2} = "-g" ] ||
     [ ${1} = "-i" -a ${2} = "--graphics" ] ||
     [ ${1} = "--install" -a ${2} = "-g" ] ||
     [ ${1} = "--install" -a ${2} = "--graphics" ]
then
    declare -a CMD_GRAPHICS_KDE=('gwenview' 'krita' 'inkscape' 'sozi' 'ink-generator' 'kruler' 'scribus' 'scribus-template' 'digikam' 'kipi-plugins' 'peruse' 'blender' 'blender-ogrexml-1.9')
    Install_Suite ${CMD_GRAPHICS_KDE[@]}
    exit

### install Utilities app suite
elif [ ${1} = "-i" -a ${2} = "-u" ] ||
     [ ${1} = "-i" -a ${2} = "--utilities" ] ||
     [ ${1} = "--install" -a ${2} = "-u" ] ||
     [ ${1} = "--install" -a ${2} = "--utilities" ]
then

    PPA_Exist /etc/apt/sources.list.d/duktos.list "echo 'deb http://download.opensuse.org/repositories/home:/colomboem/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/dukto.list"

    declare -a CMD_UTILITIES_KDE=('rsibreak' 'kcharselect' 'kcalc' 'synergy' 'ark' 'filelight' 'gufw' 'dukto')
    Install_Suite ${CMD_UTILITIES_KDE[@]}
    exit
fi