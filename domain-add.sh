#!/bin/bash

read -p "Enter your name:" name
found=0
roll_number=0
while IFS=' ', read -r fname froll_number; do
    if [ "$name" = "$fname" ]
    then
        found=1
        roll_number=$froll_number
    fi
done < menteeDetails.txt

if [ $found -eq 0 ]
then echo "No such mentee exists"
else
    #Enter your domain preferences
    echo "Enter your domain preference separated by a space (Example: web app sysad)"
    read domain_pref

    #Separating using space as delimeter
    IFS=' '
    domain_arr=($domain_pref)
    echo "${domain_arr[0]}->${domain_arr[1]}->${domain_arr[2]}" >> "/home/core/mentees/$name/domain_pref.txt"
    echo "${roll_number} ${name} ${domain_arr[0]}->${domain_arr[1]}->${domain_arr[2]}" >> "/home/core/mentees_domain.txt"

    for domain in "${domain_arr[@]}"
    do 
        sudo mkdir "/home/core/mentees/$name/$domain"
    done
fi