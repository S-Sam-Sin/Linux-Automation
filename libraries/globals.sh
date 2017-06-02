#!/usr/bin/env bash
# App Suites
declare -a CMD_OFFICE_KDE=('libreoffice' 'libreoffice-style-breeze' 'libreoffice-kde' 'focuswriter' 'kontact' 'kdepim-addons' 'okular' 'okular-extra-backends')

declare -a CMD_DEV_KDE=('kdevelop' 'kdevelop-python' 'kdevelop-php' 'mysql-workbench' 'phpmyadmin' 'qtcreator')

declare -a CMD_GRAPHICS_KDE=('gwenview' 'krita' 'inkscape' 'sozi' 'ink-generator' 'kruler' 'scribus' 'scribus-template' 'digikam' 'kipi-plugins' 'peruse' 'blender' 'blender-ogrexml-1.9')

declare -a CMD_UTILITIES_KDE=('rsibreak' 'kcharselect' 'kcalc' 'synergy' 'ark' 'filelight' 'gufw' 'dukto')


# Third party PPA
PPA_DUKTO_LIST=/etc/apt/sources.list.d/duktos.list
PPA_DUKTO_ADD="echo 'deb http://download.opensuse.org/repositories/home:/colomboem/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/dukto.list"

