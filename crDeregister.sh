#!/bin/bash

while IFS=' ' read -r name roll_number;do
        if [ ! -s "/home/core/mentees/$name/domain_pref.txt" ]
        then
            rm -rf /home/core/mentees/$name

            echo $(grep -v $name menteeDetails.txt) > temp_file.txt
            mv temp_file.txt menteeDetails.txt

            echo $(grep -v $name mentees_domain.txt) > temp_file.txt
            mv temp_file.txt mentees_domain.txt

            sudo userdel $name
        fi
done < menteeDetails.txt