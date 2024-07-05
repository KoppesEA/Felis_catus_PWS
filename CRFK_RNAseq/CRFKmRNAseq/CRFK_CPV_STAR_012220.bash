#!/bin/bash
#
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 1-00:00 # Runtime in D-HH:MM
#SBATCH -J STARz
#SBATCH --output=CRFK_CPV_STAR-%A_%a.out
#SBATCH --cpus-per-task=4 # Request that ncpus be allocated per process.
#SBATCH --mem=48g # Memory pool for all cores (see also --mem-per-cpu)
##array should start from zero
#SBATCH --array=0-3

module load star/2.7.0e

names=($(cat SRR_Acc_List.txt))
echo ${names[${SLURM_ARRAY_TASK_ID}]}

READ_BASE=${names[${SLURM_ARRAY_TASK_ID}]}
WKDIR=/bgfs/rnicholls/Cat_CRFK/GSE124753_CPV
INPUT_FASTQ1_trim=$WKDIR/$READ_BASE/${READ_BASE}_1_val_1.fq.gz
INPUT_FASTQ2_trim=$WKDIR/$READ_BASE/${READ_BASE}_2_val_2.fq.gz
ANNOTDIR=/bgfs/rnicholls/REFGenomes/Fcat_9.0/STAR

echo $READ_BASE
echo $INPUT_FASTQ1_trim
echo $INPUT_FASTQ2_trim
echo $ANNOTDIR


# Alignment by STAR

rm -rf ./${READ_BASE}tmp/*
rmdir ./${READ_BASE}tmp
mkdir ./${READ_BASE}

STAR \
--outTmpDir ./${READ_BASE}tmp \
--runThreadN 4 \
--outFilterIntronMotifs RemoveNoncanonicalUnannotated \
--readFilesCommand gunzip -c \
--chimSegmentMin 15 \
--chimOutType Junctions \
--twopassMode Basic \
--readFilesIn $INPUT_FASTQ1_trim $INPUT_FASTQ2_trim \
--outFileNamePrefix ./${READ_BASE}/${READ_BASE} \
--quantMode GeneCounts \
--outStd Log \
--genomeDir $ANNOTDIR \
--outSAMtype BAM SortedByCoordinate