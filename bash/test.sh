#!/bin/bash
lanadr1=$(ip a |awk '/: ens33/{gsub(/:/,"");print $2}')
MyLANaddress=$(ip a s $lanadr1 |awk '/inet /{gsub(/\/.*/,"");print $2}')


hname1=$(ip a |awk '/: ens33/{gsub(/:/,"");print $2}')
hname2=$(ip a s $hname1| awk '/inet /{gsub(/\/.*/,"");print $2}')
MyHostname=$(getent hosts $hname2 | awk '{print $2}')

MyExternalIp=$(curl -s icanhazip.com)

cmdcurl=$(curl -s icanhazip.com)
MyExternalName=$(getent hosts $cmdcurl | awk '{print $2}')


cat <<EOF
Hostname        : $(hostname)
LAN Address     : $MyLANaddress
LAN Hostname    : $MyHostname
External IP     : $MyExternalIp
External Name   : $MyExternalName
EOF
