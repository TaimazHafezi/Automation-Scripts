#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
echo "Please Enter First Number: "
read Firstnum

echo "Please Enter Second Number: "
read Secondnum

echo "Please Enter Third Number: "
read Thirdnum
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label
# sum of first and second and third number
sum=$((Firstnum + Secondnum + Thirdnum))
# product of first and second and third number
product=$((Firstnum * Secondnum * Thirdnum))
cat <<EOF
$Firstnum plus $Secondnum plus $Thirdnum is $sum
$Firstnum multiplied to $Secondnum multiplied to $Thirdnum is $product
EOF
