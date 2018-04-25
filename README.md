
# Example how to setup a SLURM batch process launching data-parallelized computation

## Introduction

We say that a task is embarassingly (or pleasantly) parallel when the computation performed in each task is the same, but the input data is different for each task. In that case it is possible to parcel out computation in parallel to speed up the entire computation.

## Setup of the example

It is a good idea to structure your code so that you have a distinct piece of code (a script or a function) processing just one task. In this example, there is an example of a shell script and a python script that process just one file, which is given to the script as the first argument. In general you will need the following: 

- the script processing a single task (let's say, processing one file of data)
- the list of input files to parallelize
- the directory where the input files are located
- the slurm script that parallelizes the single task

## Concrete examples

Let's say we have 7 files to process. These were generated as manual pages on unix system for some common commands. They are cat.txt  ll.txt  ls.txt  man.txt  sed.txt  sort.txt  uniq.txt located in the directory directory_to_process. The single task we will do is 

### Python example - counting words in each file 
- count words in the file in the case of the python script
- example of a pipeline in bash which consists of deleting non-alphabetic characters and then counting the number of lines, words and characters in each file. 

## Important notes

1. If there are any intermediate files produced, be careful to give it unique names for each task if you are writing those files on network mounted directories such as your home or scratch directory. Otherwise, different nodes might use the same name and overwrite each other's results. 

2. If you are using your version of (say) python, your need to give it specific path. If you are using system version of python, you need "module load python" command in your slurm script

3. A note on absolute and relative paths: TODO (where do you lauch your batch script; how do you specify ) I prefer absolute paths

4. Silly note: you cannot leave any spaces in variable definitions in bash: e.g. WORK_DIR = /path/to/dir   is not going to assign anything WORK_DIR. You must do WORK_DIR=/path/to/dir 


