#!/bin/bash
read -p "Commit description: " desc
git add . 
git commit -m "$desc" > ./log.txt
grep '^\[.*' ./log.txt > graph.mk