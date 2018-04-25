#!/bin/bash

#SBATCH --job-name=kris_hello ## Replace with your jobname 
#SBATCH --partition=main # Partition (job queue) 
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --cpus-per-task=1 ## keep it 1 in most cases
#SBATCH --mem=100 # Real memory per node required (MB) 
#SBATCH --time=00:10:00 # Total run time limit (HH:MM:SS) 
#SBATCH --array=0-5  # defines an array job

#SBATCH --mail-type=ALL
#SBATCH --mail-user=kp807@oarc.rutgers.edu

#SBATCH --output=slurm.%N.%j.out     # STDOUT output file
#SBATCH --error=slurm.%N.%j.err      # STDERR output file (optional)

### Declare job non-rerunable
#SBATCH --no-requeue


WORKING_DIRECTORY='/home/kp807/projects/aditi_data/example_data_parallelization/'  # change this to your directory
readarray FILELIST < $WORKING_DIRECTORY/list_of_files_for_parallel_process.txt

# Note: I'm passing relative path to file (e.g. "directory_to_process/cat.txt") to the bash script. 
# This works because the bash script deals with relative paths
/home/kp807/projects/aditi_data/single_task_script.sh directory_to_process/${FILELIST[$SLURM_ARRAY_TASK_ID]} 
