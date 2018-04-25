#!/bin/bash

#SBATCH --job-name=kris_hello ## Replace with your jobname 
#SBATCH --partition=main # Partition (job queue) 
#SBATCH -N 1 # Number of nodes  - since it is an array job, choose 1 node per array index
#SBATCH -n 1 # Number of tasks  - since it is an array job, choose 1 node per array index
#SBATCH --cpus-per-task=1 ## keep it 1 in most cases
#SBATCH --mem=100 # Real memory per node required (MB) 
#SBATCH --time=00:10:00 # Total run time limit (HH:MM:SS) 
#SBATCH --array=0-5  #how many do we have?  count the files with 'wc -l list_of_files_for_parallel_process.txt'

#SBATCH --mail-type=ALL
#SBATCH --mail-user=kp807@oarc.rutgers.edu

#SBATCH --output=slurm.%N.%j.out     # STDOUT output file
#SBATCH --error=slurm.%N.%j.err      # STDERR output file (optional)

### Declare job non-rerunable
#SBATCH --no-requeue


WORKING_DIRECTORY='/home/kp807/projects/aditi_data/example_data_parallelization/'  # change this to your directory
readarray FILELIST < $WORKING_DIRECTORY/list_of_files_for_parallel_process.txt     # read the list of files into variable of type array in bash, called FILELIST

echo $WORKING_DIRECTORY/directory_to_process/${FILELIST[$SLURM_ARRAY_TASK_ID]}     # you can omit this command, this is for debug purposes only

# NOTE: SLURM_ARRAY_TASK_ID is a slurm variable that keeps track of which task in the array job you are processing
# NOTE: ${FILELIST[$SLURM_ARRAY_TASK_ID]}  is the SLURM_ARRAY_TASK_IDth entry in the array variable FILELIST
/home/kp807/projects/aditi_data/single_task_script.py $WORKING_DIRECTORY/directory_to_process/${FILELIST[$SLURM_ARRAY_TASK_ID]} 

