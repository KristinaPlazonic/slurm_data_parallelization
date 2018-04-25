#!/home/kp807/anaconda3/bin/python

from functools import reduce
import sys
import os.path

def computeOneFile(filename):
    """ This is an example of a computation to parallelize. In this case, we count the number of words in the given file.  
    """
    with open(filename, 'r') as f:
       #### implement your own code here. 
       a = f.readlines()
       result = reduce(lambda x,y : x+y, map(lambda x: len(x.split(" ")), a))
       return result

def getOutputFilename(input_filename):
    """  
       Some manipulation of the input filename to produce the output filename
       In this case we change the extension to "wordcount"
    """
    dirname = os.path.dirname(input_filename)
    filename = os.path.basename(input_filename)
    return dirname + "/" + filename.split(".")[0] + ".wordcount"

def processOneFile(filename):
    """ the final function that will be parallelized via slurm 
        it consists of performing a computation and writing the result to a new file. 
    """
    with open(getOutputFilename(filename), 'w') as f:
       f.write(str(computeOneFile(filename)))

# usage:   ./single_node_script.py  filename_to_process.txt
input_filename = sys.argv[1]  # sys.argv[1] is the "filename_to_process.txt"; sys.argv[0]  is the name of the program
processOneFile(input_filename)

