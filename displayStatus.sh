#!/bin/bash



if [ "$#" -gt 0 ] 
then
    domains=("$@")
else
    domains=( web app sysad )
fi

touch "/home/core/submitted_list.txt"
last_timestamp=$(sort -n -k 1 /home/core/submitted_list.txt | tail -1 | awk '{print $1}')

for domain in "${domains[@]}"
do
    total_mentees=$(grep -c "$domain" "/home/core/mentees_domain.txt")
    tasks=( task1 task2 task3 )

    for task in "${tasks[@]}"
    do
        task_completed=0

        while IFS=' ', read -r name roll_number;do
            if grep -q "${domain}-${task}" "/home/core/mentees/$name/task_completed.txt";
            then
                (( task_completed++ ))

                echo "$(date +%s) $name $roll_number $domain $task $(cat /home/core/mentees/$name/$domain/$task/submissions.txt)" >> "/home/core/submitted_list.txt"

            fi
        done < "$(awk '/$domain/ {print $2,$1}' /home/core/mentees_domain.txt)"
        percentage_submitted=$((task_completed*100/total_mentees))
        echo "${domain} ${task} percentage= ${percentage_submitted}%"
    done
    echo
done
echo "New Submissions since last run:"
awk -v timestamp="$last_timestamp" '$1 > $timestamp {print $2,$3,$4,$5,$6}' "/homecore/submitted_list.txt"