#!/bin/bash

# Directories
wkdir="/Users/koppesea/Documents/Bioinfx/Bioinformatics_2024/CRFK_PWS_mRNASeq"
trim_dir="${wkdir}/FastqTrim"
align_dir="${wkdir}/CRFK_PWS_mRNASeq/StarAlign"
index_dir="${wkdir}/Fcat9_refgenome/STARindex"  # Replace with actual path to STAR genome index

# Log file
log_file="${align_dir}/alignment_log.txt"

# Create the output directory if it doesn't exist
mkdir -p ${align_dir}

# Initialize the log file
echo "STAR alignment process started at $(date)" > ${log_file}

# Loop through samples S54 to S59
for sample in {54..59}; do
    # Construct file names
    base_name="EK155_S${sample}"
    trim_R1="${trim_dir}/${base_name}_trimmed_R1.fastq.gz"
    trim_R2="${trim_dir}/${base_name}_trimmed_R2.fastq.gz"
    
    # Output directory for this sample
    sample_out_dir="${align_dir}/${base_name}"
    mkdir -p ${sample_out_dir}
    
    # Log the start of processing for this sample
    echo "Aligning ${base_name} started at $(date)" >> ${log_file}
    
    # Run STAR alignment
    STAR --runThreadN 8 \
         --genomeDir ${index_dir} \
         --readFilesIn ${trim_R1} ${trim_R2} \
         --readFilesCommand zcat \
         --outFileNamePrefix ${sample_out_dir}/${base_name}_ \
         --outSAMtype BAM SortedByCoordinate \
         --outSAMunmapped Within \
         --outSAMattributes Standard \
         --limitBAMsortRAM 12000000000 \
         --outReadsUnmapped Fastx \
         >> ${log_file} 2>&1
    
    # Log the completion of processing for this sample
    echo "Aligned ${base_name} - output saved in ${sample_out_dir}" >> ${log_file}
    echo "Aligning ${base_name} completed at $(date)" >> ${log_file}
    echo "----------------------------------------" >> ${log_file}
done

# Log the completion of the entire process
echo "STAR alignment process completed at $(date)" >> ${log_file}
