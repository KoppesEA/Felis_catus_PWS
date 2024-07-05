#!/bin/bash
#
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 3-00:00 # Runtime in D-HH:MM
#SBATCH -J FcatBowtieBuild 
#SBATCH --cpus-per-task=16 # Request that ncpus be allocated per process.
#SBATCH --mem=128g # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --output=FcatBowtieBuild_indexing.out
 
module load gcc/8.2.0
module load bowtie2/2.3.4.2 

GenDIR=/bgfs/rnicholls/REFGenomes/Fcat_9.0

bowtie2-build \
--threads 16 \
$GenDIR/Felis_catus.Felis_catus_9.0.dna.toplevel.fa \
$GenDIR/Fcat9Bowtie2/Fcat9bt2index
