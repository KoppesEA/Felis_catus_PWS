#!/bin/bash
#
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 1-00:00 # Runtime in D-HH:MM
#SBATCH -J SRAtools
#SBATCH --output=SRAtools-%A_%a.out
#SBATCH --cpus-per-task=1 #
#SBATCH --mem=32g # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --array=0-3

names=($(cat SRR_Acc_List.txt))
echo ${names[${SLURM_ARRAY_TASK_ID}]}

NCBIDIR=/ihome/rnicholls/eak37/ncbi/public/sra
SRR_BASE=${names[${SLURM_ARRAY_TASK_ID}]}

echo $SRR_BASE

module load sra-toolkit/2.9.2

fastq-dump --split-files $SRR_BASE
gzip ${SRR_BASE}*.fastq
rm $NCBIDIR/${SRR_BASE}.sra









