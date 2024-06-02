#!/bin/bash

name=$USER
found=0

while IFS=' ', read -r mentee_name roll_number;do
    if [ $name = $mentee_name ]
    then
        found=1
        read -p "Enter domain name (web, app or sysad):" domain_name
        read -p "Enter task number:" task_no
        if grep -q . "/home/core/mentees/$name/task_submitted.txt"
        then
            sed "s|${domain_name}-task${task_no}:n|${domain_name}-task${task_no}:y|" "/home/core/mentees/$name/task_submitted.txt"
        else
            while IFS='=>', read -r domain;
            do
                for task_number in {1..3}
                do
                    echo "${domain}-task${task_number}:n" >> "/home/core/mentees/$name/task_submitted.txt"
                done
            done < "/home/core/mentees/$name/domain_pref.txt"
            sed "s|${domain_name}-task${task_no}:n|${domain_name}-task${task_no}:y|" "/home/core/mentees/$name/task_submitted.txt"
        fi
        mkdir "/home/core/mentees/$name/$domain_name/task$task_no"

        read -p "Enter github repo name:" repo
        touch "/home/core/mentees/$name/$domain_name/task$task_no/submissions.txt"
        echo $repo >> "/home/core/mentees/$name/$domain_name/task$task_no/submissions.txt"
    fi
done < menteeDetails.txt

while IFS=' ', read -r mentor_name mentor_domain mentee_capacity;do
    if [ $name = $mentor_name ]
    then
        found=1
        while IFS=' ', read -r mentee_name roll_number;do    
            ln -sf  "/home/core/mentees/$mentee_name/mentor_domain/" "/home/core/mentors/$mentor_domain/$mentor_name/submitted_Tasks/"
            if  [ -d "/home/core/mentees/$mentee_name/$mentor_domain/" ]
            then
                while IFS=' ', read -r task;do
                    echo "${mentor_domain}-${task}" >> "/home/core/mentees/$mentee_name/task_completed.txt"
                done < "$(ls /home/core/mentees/$mentee_name/$mentor_domain/)"
            fi
        done <  "/home/core/mentors/$mentor_domain/$mentor_name/allocatedMentees.txt"
    fi
done < mentorDetails.txt

if [ $found -eq 0 ]
then
    echo "Only a mentor or mentee can run this function"
fi