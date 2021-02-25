#!/bin/bash
day=$(date +%A)
if [ $day == "Monday" ]
then
  title="In all of the mania that Mondays bring, Don't forget to take care of yourself"
fi
hostname=$(hostname)


#day=$(date +%A)
#if [ $day == "Monday" ]
#then
  #title="Monday is funday"
#fi
cat << EOF
Welcome to planet $hostname, $title
EOF
