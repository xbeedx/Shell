#!/bin/bash

readarray -t branches < <(git branch --format="%(refname:short)")
commitsDone=()

>log.txt
>graph.md

echo -e  '```mermaid\n\tgitGraph' >> graph.md
for (( i=${#branches[@]}-1; i>=0; i-- ))
do
    branch=${branches[i]}
    echo -e "Branch Name: $branch \n Commits:" >> log.txt
    readarray commits < <(git log $branch --format="%H %an %s")
    if [ "$branch" != "main" ];
    then
       echo -e "\tbranch $branch" >> graph.md
    fi
    for ((j=${#commits[@]}-1; j>=0; j-- ))
    do
        commit=${commits[j]}
        commitFields=($commit)
        name=""
        for ((k=2; k<${#commitFields[@]}; k++)); do
            name+=" ${commitFields[k]}"
        done
        name="${name# }"
        if [[ ! "${commitsDone[@]}" =~ "$name" ]];
        then
            echo -e  "\tcommit id:\"$name\""  >> graph.md
            commitsDone+=("$name")
            echo -e "  $commit" >> log.txt
        fi
    done
done
echo -e  '```" >> graph.md

