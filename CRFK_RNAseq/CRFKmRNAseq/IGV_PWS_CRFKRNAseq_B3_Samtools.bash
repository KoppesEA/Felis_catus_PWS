#!/bin/bash
#
#SBATCH -N 1
#SBATCH -t 1-00:00
#SBATCH -J SamRIP
#SBATCH --output=PWS_BAMprep
#SBATCH --cpus-per-task=4


##Script to extract bam files for Fcat chrB3 and the PWS loci from CRFK RNAseqdata

WKDIR=/bgfs/rnicholls/Cat_CRFK/GSE124753_CPV
OUTDIR=$WKDIR/wiggle

module load gcc/8.2.0
module load samtools/1.9

for bamfile in ${WKDIR}/SRR*/*.bam
do
echo $bamfile

filebase=`basename $bamfile .bam`
echo $filebase

#index sorted BAM files (CRFK Fact 9.0 STAR alginment)
samtools index $bamfile

#extract all chr1 alignments from sorted BAM file and redirect output to wiggle folder
samtools view -@ 4 -b -o $OUTDIR/${filebase}_ChrB3.bam $bamfile "B3"
samtools view -@ 4 -b -o $OUTDIR/${filebase}_PWS.bam $bamfile "B3:22500000-25750000"


#index extract alignment files
samtools index -@ 4 $OUTDIR/${filebase}_ChrB3.bam
samtools index -@ 4 $OUTDIR/${filebase}_PWS.bam

done
