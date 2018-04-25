#!/bin/bash

### This is an example of a bash (shell) script
### It takes a single argument which is the name of the file to process through some pipeline
### In this case the pipeline is a genomic pipeline
###    1. trimmomatic (trim reads)
###    2. fastqc   (get phred scores)
###    3. bowtie2  ()
###    4. samtools (alignment)
###    5. bcftools (variant calling)

trim_path = "/home/ag1349/software/Trimmomatic-0.36/trimmomatic-0.36.jar"
adaptor_path = "/home/ag1349/software/Trimmomatic-0.36/adapters/TruSeq3-PE.fa"

### TODO:   need to fix the names of files and directories, with some care. 
INPUT_FILE=$1   #In the bash script, $0 is the name of the script and $1 is the argument

### Some manipulation of the input file to get the output file name
WORKING_DIR=`pwd`         #handy way to get current directory

#trim
java -jar $trim_path PE -phred33 $fq_1 $fq_2 s1_pe.fq.gz s1_se.fq.gz s2_pe.fq.gz s2_se.fq.gz ILLUMINACLIP:$(adaptor_path):2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:20 &> qc.run

#run fastqc
/home/ag1349/software/FastQC/fastqc ...

qcdir = 
mapdir = 

#run bowtie
bowtie2 -p 8 -x /home/ag1349/Hassan/Zhangetal2013/H37Rv/H37Rv -1 $qcdir/s1_pe.fq.gz -2 $qcdir/s2_pe.fq.gz -U $qcdir/s1_se.fq.gz, $qcdir/s2_se.fq.gz -S $mapdir/aln.sam &> map.run

#run the rest of pipeline  -- note that parallel scripts will be run on the same directory so probably need to rename the generic name to make it sequence spedific
SD =   # sequence name
samtools view -bS aln.sam > aln.bam
samtools sort aln.bam aln.sorted
samtools mpileup -f /home/ag1349/Hassan/Zhangetal2013/H37Rv/H37Rv.fa aln.sorted.bam > aln.sorted.bam.mpileup
samtools mpileup -go $SD.bcf -f /home/ag1349/Hassan/Zhangetal2013/H37Rv/H37Rv.fa aln.sorted.bam
bcftools call -vmO z -o $SD.vcf.gz $SD.bcf
rm $SD.bcf # delete bcf file as mpileup output is already stored
mv aln.sorted.bam $SD.aln.sorted.bam
samtools index $SD.aln.sorted.bam

