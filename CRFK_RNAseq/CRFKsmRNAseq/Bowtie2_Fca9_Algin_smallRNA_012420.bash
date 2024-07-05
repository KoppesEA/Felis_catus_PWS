#!/bin/bash
#
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 1-00:00 # Runtime in D-HH:MM
#SBATCH -J Bowtie2smallRNA
#SBATCH --output=Bowtie2smallRNA-%A_%a.out
#SBATCH --cpus-per-task=4 # Request that ncpus be allocated per process.
#SBATCH --mem=64g # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --array=0-5

module load gcc/8.2.0
module load bowtie2/2.3.4.2
 
names=($(cat SRR_Acc_List.txt))
WKDIR=/bgfs/rnicholls/Cat_CRFK/GSE135948_smallRNA
READ_BASE=${names[${SLURM_ARRAY_TASK_ID}]}
INPUT_FASTQ_1=$WKDIR/$READ_BASE/${READ_BASE}_1_trimmed.fq.gz
BOWTIE_INDEX=/bgfs/rnicholls/REFGenomes/Fcat_9.0/Fcat9Bowtie2/Fcat9bt2index

echo $READ_BASE
echo $INPUT_FASTQ_1
echo $INPUT_FASTQ_2
echo $BOWTIE_INDEX

bowtie2 \
-p 4 \
-x $BOWTIE_INDEX \
-U $INPUT_FASTQ_1 \
-S $WKDIR/Bowtie2aligned/${READ_BASE}.sam

