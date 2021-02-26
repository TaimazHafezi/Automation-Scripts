#!/bin/bash
HOSTNAME=$(hostname)
NIC_INTERFACE=$(ip a | awk '/2: e/{gsub(/:/,"");print $2}')
LAN_ADDRESS=$(ip a s $NIC_INTERFACE | awk '/inet /{gsub(/\/.*/,"");print $2}')
LAN_HOST_NAME=$(getent hosts $LAN_ADDRESS | awk '{print $2}')
EXTERNAL_IP=$(curl -s icanhazip.com)
EXTERNAL_NAME=$(getent hosts $EXTERNAL_IP | awk '{print $2}')
ROUTER_ADDRESS=$(ip r | awk '/default/{print $3}')
ROUTER_HOST_NAME=$(cat /etc/hosts | awk '/'$ROUTER_ADDRESS'/{print$2}')

cat <<EOF
Hostname        : $HOSTNAME
LAN Address     : $LAN_ADDRESS
LAN Hostname    : $Lan_HOST_NAME
External IP     : $EXTERNAL_IP
External Name   : $EXTERNAL_NAME
EOF
