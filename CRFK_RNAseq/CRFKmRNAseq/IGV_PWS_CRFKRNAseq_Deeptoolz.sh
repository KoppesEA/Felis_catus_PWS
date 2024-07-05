#!/bin/bash
#
#SBATCH -N 1
#SBATCH -t 1-00:00
#SBATCH -J DeepToolz
#SBATCH --output=PWS_wiggleprep
#SBATCH --cpus-per-task=1


##Script to extract convert .bam to .bw for Fcat PWS chr B3 and loci

WKDIR=/bgfs/rnicholls/Cat_CRFK/GSE124753_CPV
OUTDIR=$WKDIR/wiggle

module load deeptools/3.3.0

for bamfile in ${WKDIR}/SRR*/*.bam
do
echo $bamfile

filebase=`basename $bamfile .bam`
echo $filebase

bamCoverage -b $OUTDIR/${filebase}_ChrB3.bam -o $OUTDIR/${filebase}_ChrB3.bw
bamCoverage -b $OUTDIR/${filebase}_PWS.bam -o $OUTDIR/${filebase}_PWS.bw

done
