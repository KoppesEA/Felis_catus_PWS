#!/bin/bash
#
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 1-00:00 # Runtime in D-HH:MM
#SBATCH -J STARFcat
#SBATCH --output=genSTARGenome-%A_%a.out
#SBATCH --cpus-per-task=16 # Request that ncpus be allocated per process.
#SBATCH --mem=128g # Memory pool for all cores (see also --mem-per-cpu)

module load star/2.7.9a

ANNOTDIR=/bgfs/rnicholls/REFGenomes/Fcat_9.0

STAR \
--runThreadN 16 \
--runMode genomeGenerate \
--genomeDir $ANNOTDIR/STAR_279a \
--genomeFastaFiles $ANNOTDIR/Felis_catus.Felis_catus_9.0.dna.toplevel.fa \
--sjdbGTFfile $ANNOTDIR/Felis_catus.Felis_catus_9.0.99.gtf \
--sjdbOverhang 149
