#!/bin/bash
if [ -z "$1" ]; then
    echo "Пожалуйста, передайте число в качестве аргумента."
    exit 1
fi

number=$1
while [ "$number" -ge 0 ]
do
    echo "$number"
    number=$((number - 1))
done