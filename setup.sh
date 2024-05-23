#!/bin/bash

#Creating the user
sudo useradd -m  core
sudo groupadd mentees

#Making the mentors and mentees folders
sudo mkdir /home/core/mentors
sudo mkdir /home/core/mentees
sudo touch /home/core/mentees_domain.txt

#Setting the permission for core as well as mentees in mentees_domain.txt
sudo chown -R core:core /home/core
sudo chmod -R 700 /home/core

sudo chgrp mentees /home/core/mentees_domain.txt
sudo chmod 720 /home/core/mentees_domain.txt

#Creating accounts and home directories for mentees
while IFS=' ' read -r name roll_number; do
    sudo useradd -m -d "/home/core/mentees/$name" "$name"

    sudo usermod -a -G mentees "$name"

    sudo chown -R "$name:$name" "/home/core/mentees/$name"
    sudo chmod 700 "/home/core/mentees/$name"

    sudo touch "/home/core/mentees/$name/domain_pref.txt"
    sudo touch "/home/core/mentees/$name/task_completed.txt"
    sudo touch "/home/core/mentees/$name/task_submitted.txt"
done < menteeDetails.txt

#Creating accounts and home directories for mentors
while IFS=' ' read -r name domain mentee_capacity; do
    sudo useradd -m -d "/home/core/mentors/$domain/$name" "$name"

    sudo mkdir "/home/core/mentors/$domain/$name/submittedTasks"

    sudo chown -R "$name:$name" "/home/core/mentors/$name"
    sudo chmod 700 "/home/core/mentors/$domain/$name"
    
    sudo mkdir "/home/core/mentors/$domain/$name/submittedTasks/task1"
    sudo mkdir "/home/core/mentors/$domain/$name/submittedTasks/task2"
    sudo mkdir "/home/core/mentors/$domain/$name/submittedTasks/task3"
    sudo touch "/home/core/mentors/$domain/$name/allocatedMentees.txt"
done < mentorDetails.txt