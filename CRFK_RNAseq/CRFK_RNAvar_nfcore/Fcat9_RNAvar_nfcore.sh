#!/bin/bash
#
#SBATCH --job-name=nextflow_head
#SBATCH -c 1
#SBATCH --mem=8g
#SBATCH -t 3-00:00 # Runtime in D-HH:MM
#SBATCH --output=nextflow_head.out
#SBATCH --mail-user=eak37@pitt.edu
#SBATCH --mail-type=ALL

unset TMPDIR

module purge
module load nextflow/23.10.1
module load singularity/3.9.6
export NXF_SINGULARITY_CACHEDIR=/ihome/crc/install/genomics_nextflow/nf-core-rnavar-1.0.0/singularity-images
export SINGULARITY_CACHEDIR=/ihome/crc/install/genomics_nextflow/nf-core-rnavar-1.0.0/singularity-images

SEQDIR=/bgfs/rnicholls/Cat_CRFK/GSE124753_CPV
OUTDIR=$SEQDIR/RNAvar-nfcore
WKDIR=$OUTDIR/RNAvar-nfcore/work
REFDIR=/bgfs/rnicholls/REFGenomes/Fcat_9.0

nextflow run /ihome/crc/install/genomics_nextflow/nf-core-rnavar-1.0.0/workflow \
	-resume \
	-name EAK_Fcat_RNAvar_run3 \
	-profile htc \
	-work-dir $WKDIR/ \
	--input $OUTDIR/samplesheet.csv \
	--outdir $OUTDIR/ \
	--email eak37@pitt.edu \
	--multiqc_title EAK_Fcat9_RNAvar_multiQC \
	--fasta $REFDIR/Felis_catus.Felis_catus_9.0.dna.toplevel.fa.gz \
	--gtf $REFDIR/Felis_catus.Felis_catus_9.0.99.gtf.gz \
	--aligner star \
	--star_index $REFDIR/STAR_279a \
	--read_length 150 \
	--known_indels $REFDIR/felis_catus.vcf.gz \
	--known_indels_tbi $REFDIR/felis_catus.vcf.gz.tbi \
	--skip_variantannotation 
