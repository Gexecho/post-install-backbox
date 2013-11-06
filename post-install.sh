#!/bin/bash
#
# script post-install ubuntu xubuntu
# a executer avec privileges root (sudo)
#
#
#
#             DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                     Version 2, December 2004
# 
#    Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
# 
#    Everyone is permitted to copy and distribute verbatim or modified 
#    copies of this license document, and changing it is allowed as long
#    as the name is changed.
# 
#             DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
# 
#     0. You just DO WHAT THE FUCK YOU WANT TO.
#
#------------------------------------------------------------------------

# variables

APT_GET="apt-get -y --force-yes"
ADD_REPO="apt-add-repository -y"
LIST_INSTALL="guake virtualbox xfburn gedit manpages-fr libreoffice iptux gftp" # ajoutez ou supprimez des paquets a install
LIST_REMOVE="brasero transmission-gtk filezilla abiword" # ajoutez ou supprimez des paquets a remove

#---------------------------------------------------------------------

echo " début de la post-install... "

# root ou pas ?
echo " check root privileges.."
if [ $(id -u) -ne 0 ];then
  echo '[!] root !?? (sudo)' >&2
  exit 1
fi

#---------------------------------------------------------------------

# mise à jour
clear && echo "mise a jour... patientez..."

$APT_GET update -y && clear && $APT_GET upgrade -y && clear && $APT_GET --dist-upgrade && clear 


# suppression de la LIST_REMOVE

echo " suppression des paquets... "
$APT_GET remove $LIST_REMOVE


# installation de la LIST_INSTALL

$APT_GET install $LIST_INSTALL


# Ajout du dépot d'i2p et installation

$ADD_REPO ppa:i2p-maintainers/i2p && $APT_GET update

# instalation i2p

echo " installation d'i2p "
$APT_GET install i2p


echo "supression de paquets inutiles..."

$APT_GET clean | $APT_GET purge | $APT_GET autoremove


echo "fin de la post instalation"

