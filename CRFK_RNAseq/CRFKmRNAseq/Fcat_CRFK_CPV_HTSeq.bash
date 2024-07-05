#!/bin/bash
#
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 1-00:00 # Runtime in D-HH:MM
#SBATCH -J htseq-Fcat
#SBATCH --output=htseqFcat-%A_%a.out
#SBATCH --cpus-per-task=1 # HTseq does not support multithread
#SBATCH --mem=32g # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --array=0-3

module load htseq/0.11.2

names=($(cat SRR_Acc_List.txt))
echo ${names[${SLURM_ARRAY_TASK_ID}]}

WKDIR=/bgfs/rnicholls/Cat_CRFK/GSE124753_CPV
READ_BASE=${names[${SLURM_ARRAY_TASK_ID}]}
BAM_FILE=$WKDIR/$READ_BASE/${READ_BASE}Aligned.sortedByCoord.out.bam
ANNOT=/bgfs/rnicholls/REFGenomes/Fcat_9.0/Felis_catus.Felis_catus_9.0.99.gtf

echo $WKDIR
echo $READ_BASE
echo $BAM_FILE
echo $ANNOT

htseq-count \
--format bam \
--order pos \
--mode union \
--nonunique all \
--minaqual 1 \
--stranded no \
--type exon \
--idattr gene_id \
--additional-attr gene_name \
$BAM_FILE $ANNOT > $WKDIR/htseq_union_all/${READ_BASE}_gene_counts

htseq-count \
--format bam \
--order pos \
--mode union \
--nonunique none \
--minaqual 1 \
--stranded no \
--type exon \
--idattr gene_id \
--additional-attr gene_name \
$BAM_FILE $ANNOT > $WKDIR/htseq_union_none/${READ_BASE}_gene_counts