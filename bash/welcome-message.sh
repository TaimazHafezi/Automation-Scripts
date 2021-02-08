#!/bin/bash
#
# This script produces a dynamic welcome message
# it should look like
#   Welcome to planet hostname, title name!

# Task 1: Use the variable $USER instead of the myname variable to get your name

###############
# Variables   #
###############


# Task 2: Dynamically generate the value for your hostname variable using the hostname command - e.g. $(hostname)
hostname=$(hostname)

# Task 3: Add the time and day of the week to the welcome message using the format shown below
#   Use a format like this:
date=$(date +%T%p)
day=$(date +%A)
# Task 4: Set the title using the day of the week
#   e.g. On Monday it might be Optimist, Tuesday might be Realist, Wednesday might be Pessimist, etc.
#   You will need multiple tests to set a title
#   Invent your own titles, do not use the ones from this example
if [ $day == "Monday" ]
then
  title="In all of the mania that Mondays bring, Don't forget to take care of yourself."
elif [ $day == "Tuesday"]
then
  title="Thank goodness Monday is gone. Happy Tuesday."
elif [ $day == "Wednesday"]
then
  title="May your Wednesday be a blessed day."
elif [ $day == "Thursday"]
then
  title="Today is Thursday? Whoopee, that means that Friday is almost here!"
elif [ $day == "Friday"]
then
  title="Happiness is a day called Friday."
elif [ $day == "Saturday"]
then
  title="Today is Saturday, that means you can sleep more"
else
  title="Sunday is funday"
fi
hostname=$(hostname)



###############
# Main        #
###############
cat <<EOF #   It is weekday at HH:MM AM.
It is $day at $date
Welcome to planet $hostname, "$title $USER!"

EOF
