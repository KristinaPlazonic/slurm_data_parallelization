#!/bin/bash

### This is an example of a bash (shell) script
### It takes a single argument which is the name of the file to process through some pipeline
### In this case the pipeline is a dummy 2-step pipeline for demo purposes consisting of 
###    1. deleting every non-alphabetic character, except space, which is the command   tr -dc '[:alpha:][:space:]'
###    2. counting the number of lines, words and and characters in the processed file, which is the command wc (word count)

INPUT_FILE=$1   #In the bash script, $0 is the name of the script and $1 is the argument

### Some manipulation of the input file to get the output file name
WORKING_DIR=`pwd`         #handy way to get current directory
OUTPUT_FILE=$WORKING_DIR/$INPUT_FILE.counts

#note that you can separate lines for visibility by putting \ character at the end of line
#note that there can be no trailing spaces after \ in that case
cat $INPUT_FILE | \
    tr -dc '[:alpha:][:space:]' | \
    wc    > $OUTPUT_FILE

