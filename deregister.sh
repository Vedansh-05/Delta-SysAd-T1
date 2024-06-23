#!/bin/bash

while IFS=' ' read -r name roll_no;do
    if [ $USER = $name ]
    then
        read -p "Enter the domain you want to deregister from." dereg_domain

        #remove the domain directory from the mentees home directory
        rmdir -r /home/core/mentees/$name/$domain
        
        domain_arr=() #an array to store the domains the mentee is still registered to
        while IFS="->" read -r domain;do
            if [ $domain = $dereg_domain ]
            then
                continue
            fi
            domain_arr+=("$domain")
        done < "/home/core/mentees/$name/domain_pref.txt"

        echo "${domain_arr[@]}" | sed 's/ /->/g' > /home/core/mentees/$name/domain_pref.txt

        while IFS=' ' read -r mentor_name;do
            if grep -q $name "/home/core/mentors/$dereg_domain/$mentor_name/allocatedMentees.txt";
            then
                echo $(grep -v $name "/home/core/mentors/$dereg_domain/$mentor_name/allocatedMentees.txt") > temp_file.txt
                mv temp_file.txt "/home/core/mentors/$dereg_domain/$mentor_name/allocatedMentees.txt"
            fi
        done < $(ls /home/core/mentors/$dereg_domain)
    fi
done < menteeDetails.txt