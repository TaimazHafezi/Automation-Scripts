#!/bin/bash

if [ $# -eq 0 ]; then
  my_hostname=$(hostname)
  default_router_address=$(ip r s default| cut -d ' ' -f 3)
  default_router_name=$(getent hosts $default_router_address|awk '{print $2}')
  external_address=$(curl -s icanhazip.com)
  external_name=$(getent hosts $external_address | awk '{print $2}')
  cat <<EOF
  System Identification Summary
  =============================
  Hostname      : $my_hostname
  Default Router: $default_router_address
  Router Name   : $default_router_name
  External IP   : $external_address
  External Name : $external_name
EOF
fi


while [ $# -gt 0 ]; do
  case "$1" in
    -v )
    verbose="yes"
    ;;
  esac
  if [ $1 = "-v" ]; then
    [ "$verbose" = "yes" ] && echo "Gathering host information"

    my_hostname=$(hostname)
    [ "$verbose" = "yes" ] && echo "Identifying default route"

    default_router_address=$(ip r s default| cut -d ' ' -f 3)
    default_router_name=$(getent hosts $default_router_address|awk '{print $2}')
    [ "$verbose" = "yes" ] && echo "Checking for external IP address and hostname"

    external_address=$(curl -s icanhazip.com)
    external_name=$(getent hosts $external_address | awk '{print $2}')
    cat <<EOF
    System Identification Summary
    =============================
    Hostname      : $my_hostname
    Default Router: $default_router_address
    Router Name   : $default_router_name
    External IP   : $external_address
    External Name : $external_name
EOF
  break
  fi
  if [ $# -eq 1 -a "$1" != "-v" ]; then
    interface="$1"
    ipv4_address=$(ip a s $interface|awk -F '[/ ]+' '/inet /{print $3}')
    ipv4_hostname=$(getent hosts $ipv4_address | awk '{print $2}')
    network_address=$(ip route list dev $interface scope link|cut -d ' ' -f 1)
    network_number=$(cut -d / -f 1 <<<"$network_address")
    network_name=$(getent networks $network_number|awk '{print $1}')
    cat <<EOF
    Interface $interface:
    ===============
    Address         : $ipv4_address
    Name            : $ipv4_hostname
    Network Address : $network_address
    Network Name    : $network_name
EOF
  break
  fi
  shift
done





allInterfaces=$(ip a | awk '/: e/{print $2}')
#to determine how many times the loop needs to run, I need to know how many interfaces there are
numberOfInterfaces=$( ip a | awk '/: e/{print $2}' | wc -l )
for (( count=1; count <= $numberOfInterfaces; count++ )); do
  interface=$(ip a | awk '/: e/ {print $2}' | awk "NR==$count")
  [ "$verbose" = "yes" ] && echo "Reporting on interface: $interface"
  [ "$verbose" = "yes" ] && echo "Getting IPV4 address and name for interface $interface"
  ipv4_address=$(ip a s $interface|awk -F '[/ ]+' '/inet /{print $3}')
  ipv4_hostname=$(getent hosts $ipv4_address | awk '{print $2}')
  [ "$verbose" = "yes" ] && echo "Getting IPV4 network block info and name for interface $interface"
  network_address=$(ip route list dev $interface scope link|cut -d ' ' -f 1)
  network_number=$(cut -d / -f 1 <<<"$network_address")
  network_name=$(getent networks $network_number|awk '{print $1}')
  cat <<EOF
  Interface $interface:
  ===============
  Address         : $ipv4_address
  Name            : $ipv4_hostname
  Network Address : $network_address
  Network Name    : $network_name
EOF
done
