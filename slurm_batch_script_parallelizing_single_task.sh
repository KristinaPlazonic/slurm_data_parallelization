#!/bin/bash

#SBATCH --job-name=kris_hello ## Replace with your jobname 
#SBATCH --partition=main # Partition (job queue) 
#SBATCH -N 2 # Number of nodes 
#SBATCH -n 2 # Number of tasks (usually = cores) on each node
#SBATCH --cpus-per-task=1 ## keep it 1 in most cases
#SBATCH --mem=100 # Real memory per node required (MB) 
#SBATCH --time=00:10:00 # Total run time limit (HH:MM:SS) 
#SBATCH --array=0-5  #how many do we have? 

#SBATCH --mail-type=ALL
#SBATCH --mail-user=kp807@oarc.rutgers.edu

#SBATCH --output=slurm.%N.%j.out     # STDOUT output file
#SBATCH --error=slurm.%N.%j.err      # STDERR output file (optional)

### Declare job non-rerunable
#SBATCH --no-requeue

#filelistname = "/home/kp807/projects/aditi_data/list_of_files_for_parallel_process.txt"
#filelist = open(filelistname, "r").read().splitlines()


WORKING_DIRECTORY='/home/kp807/projects/aditi_data/example_data_parallelization/'  # change this to your directory
readarray FILELIST < $WORKING_DIRECTORY/list_of_files_for_parallel_process.txt

echo $WORKING_DIRECTORY/directory_to_process/${FILELIST[$SLURM_ARRAY_TASK_ID]}
/home/kp807/projects/aditi_data/single_task_script.py $WORKING_DIRECTORY/directory_to_process/${FILELIST[$SLURM_ARRAY_TASK_ID]} 
