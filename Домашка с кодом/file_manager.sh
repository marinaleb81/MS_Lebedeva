#!/bin/bash
echo 
mkdir test_directory
cd test_directory

echo 
touch file1.txt file2.txt file3.txt

ls -l

echo 
rm file1.txt file2.txt file3.txt

cd ..
echo 
rmdir test_directory