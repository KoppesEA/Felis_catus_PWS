#!/bin/bash

# Directories
genome_dir="/Users/koppesea/Documents/Bioinfx/Bioinformatics_2024/CRFK_PWS_mRNASeq/Fcat9_refgenome"  # Path to cat genome files
index_dir="${genome_dir}/STARindex"   # Path for STAR index

# Log file
log_file="${index_dir}/STARindex_generation_log.txt"

# Create the output directory if it doesn't exist
mkdir -p ${index_dir}

# Initialize the log file
echo "STAR index generation started at $(date)" > ${log_file}

# Run STAR index generation
STAR --runMode genomeGenerate \
     --runThreadN 8 \
     --genomeDir ${index_dir} \
     --genomeFastaFiles ${genome_dir}/Felis_catus.Felis_catus_9.0.dna.toplevel.fa \
     --sjdbGTFfile ${genome_dir}/Felis_catus.Felis_catus_9.0.112.gtf \
     --genomeSAindexNbases 12 \
     --limitGenomeGenerateRAM 13000000000 \
     >> ${log_file} 2>&1

# Log the completion of the process
echo "STAR index generation completed at $(date)" >> ${log_file}