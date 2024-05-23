#!/bin/bash

while IFS=' ', read -r mentee_name roll_number; do
    while IFS='->', read -r domain; do
        mentor_list="$(ls /home/core/mentors/$domain)"

        #Making a copy to not disturb the original data
        cp mentorDetails.txt mentorDetails1.txt

        while IFS=' ', read -r mentor_name; do
            mentee_capacity=$(cat mentorDetails1.txt | grep "${mentor_name}" | awk -F ' ' '{ print $3 }')
            if [ $mentee_capacity -le 0 ]
            then
                continue
            else
                #Storing the name and roll numbers in allocatedMentees.txt file
                echo "$mentee_name $roll_number" >> "/home/core/mentors/$domain/$mentor_name/allocatedMentees.txt"

                #Updating the mentee capacity in mentorDetails.txt
                echo "$(cat mentorDetails.txt  | grep -v "$mentor_name" | sort)" > mentorDetails1.txt
                echo -n $(cat mentorDetails.txt | grep "$mentor_name" | awk -F ' ' '{ print $1, $2 }') >> mentorDetails1.txt
                echo -n " " >> mentorDetails1.txt
                echo $(( $mentee_capacity-1 )) >> mentorDetails1.txt
            fi
        done < "$(sort $mentor_list)"
    done < "/home/core/mentees/$mentee_name/domain_pref.txt"
done < "$(sort menteeDetails.txt)"