#!/bin/bash
#
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 1-00:00 # Runtime in D-HH:MM
#SBATCH -J TrimO
#SBATCH --output=Trim-%A_%a.out
##array should start from zero
#SBATCH --array=0-3

module load trimgalore/0.5.0

names=($(cat SRR_Acc_List.txt))
echo ${names[${SLURM_ARRAY_TASK_ID}]}

#refer to --cpus-per-task
INPUT_FASTQ1=${names[${SLURM_ARRAY_TASK_ID}]}_1.fastq.gz
INPUT_FASTQ2=${names[${SLURM_ARRAY_TASK_ID}]}_2.fastq.gz
OUTPUT=${names[${SLURM_ARRAY_TASK_ID}]}


echo $INPUT_FASTQ1
echo $INPUT_FASTQ2
echo $OUTPUT

#Trim_galore: cutadapt
mkdir ./$OUTPUT
trim_galore --paired --retain_unpaired --output ./$OUTPUT \
$INPUT_FASTQ1 $INPUT_FASTQ2
