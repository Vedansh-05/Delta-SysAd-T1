#!/bin/bash

#Read the name of the mentee
read -p "Enter your name:" name
found=0
roll_number=0

#Check if the mentee exists
while IFS=' ', read -r fname froll_number; do
    if [ "$name" = "$fname" ]
    then
        found=1
        roll_number=$froll_number
    fi
done < menteeDetails.txt

if [ $found -eq 0 ]
then echo "No such mentee exists" #No such name found
else
    #Enter your domain preferences
    echo "Enter your domain preference separated by a space (Example: web app sysad)"
    read domain_pref

    #Separating using space as delimeter
    IFS=' '
    domain_arr=("$domain_pref")

    #Add the domains in domain_pref.txt file
    echo "${domain_arr[0]}->${domain_arr[1]}->${domain_arr[2]}" >> "/home/core/mentees/$name/domain_pref.txt"
    
    #Add the mentee details in mentees_domain.txt
    echo "${roll_number} ${name} ${domain_arr[0]}->${domain_arr[1]}->${domain_arr[2]}" >> "/home/core/mentees_domain.txt"

    #Make the domain directories in the mentee home directory
    for domain in "${domain_arr[@]}"
    do 
        sudo mkdir "/home/core/mentees/$name/$domain"
    done
fi