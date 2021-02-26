#!/bin/bash
#
# this script displays some host identification information for a simple Linux machine
#
# Sample output:
#   Hostname        : hostname
#   LAN Address     : 192.168.2.2
#   LAN Hostname    : host-name-from-hosts-file
#   External IP     : 1.2.3.4
#   External Name   : some.name.from.our.isp

# Task 1: Clean up this script by moving the commands that generate the output to separate lines
#         that put each command's output into variables. Once you have that done, Use those variables
#         in the output section at the end of the script. If the commands included in this script
#         don't make sense to you, feel free to create your own commands to find your ip addresses,
#         host names, etc.
myExternalIP=$(curl -s icanhazip.com)
#
#    then use the variable in any command that needs that data (that had that command pipeline in parentheses)
#
myExternalName=$(getent hosts $myExternalIP | awk '{print $2}')
findIp=$(ip a s $(ip a |awk '/: e/{gsub(/:/,"");print $2}')|awk '/inet /{gsub(/\/.*/,"");print $2}')
findLanHostname=$(getent hosts $findIp |awk '{print $2}')
findHostname=$(hostname)
routerIpaddress=$(ip r |grep default | awk '{print $3}')
routerName=$(getent hosts $routerIpaddress | awk '{print $1,$2}')


#
#    this makes the command to generate your external name much easier to read and understand
#    now you can use the variables you just created in your output section later in the script
#
#   External IP     : $myExternalIP
#   External Name   : $myExternalName

cat <<EOF
Hostname        : $findHostname
LAN Address     : $findIp
LAN Hostname    : $findLanHostname
External IP     : $myExternalIP
External Name   : $myExternalName
router ip       : $routerIpaddress
router name     : $routerName
EOF
