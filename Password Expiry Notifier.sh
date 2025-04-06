#!/bin/bash

threshold=7

for i in $(awk 'BEGIN {FS = ":"} {if ($3 > 1000 && $3 != 65534) {print $1} }' /etc/passwd)
do
   exp_date=$(chage -l "$i" | grep "Password expires" | awk '{print $4, $5, $6}')

   if [ $(date -d "$exp_date" +%s) -le $(date -d "+$threshold days" +%s) ]
   then
       echo "the user "$i" will change the password nearly === "$exp_date""
   else
       echo "it is so far for user "$i" to change password ------ "$exp_date""
   fi



done

#65534 = nobody
