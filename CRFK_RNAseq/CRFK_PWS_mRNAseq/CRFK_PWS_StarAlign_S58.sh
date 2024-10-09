#!/bin/bash

# Directories
wkdir="/Volumes/DKRIWC_disk2_1tb/DKRIWC_Bioinformatics/Bioinformatics_2024/CRFK_PWS_mRNASeq"
trim_dir="${wkdir}/FastqTrim"
align_dir="${wkdir}/StarAlign"
index_dir="${wkdir}/Fcat9_refgenome/STARindex" 

# Log file
log_file="${align_dir}/alignment_log_S58_rerun.txt"

# Create the output directory if it doesn't exist
mkdir -p ${align_dir}

# Initialize the log file
echo "STAR alignment process for S58 rerun started at $(date)" > ${log_file}

# Process only S58
sample=58
trim_R1="${trim_dir}/EK155_*_S${sample}_trimmed_R1.fastq.gz"
trim_R2="${trim_dir}/EK155_*_S${sample}_trimmed_R2.fastq.gz"

# Extract base name for output
base_name=$(basename ${trim_R1} _trimmed_R1.fastq.gz)

# Output directory for this sample
sample_out_dir="${align_dir}/${base_name}"
mkdir -p ${sample_out_dir}

# Remove existing files for S58
rm -rf ${sample_out_dir}/*

# Log the start of processing for this sample
echo "Aligning ${base_name} started at $(date)" >> ${log_file}

# Run STAR alignment
STAR --runThreadN 8 \
     --genomeDir ${index_dir} \
     --readFilesIn ${trim_R1} ${trim_R2} \
     --readFilesCommand gunzip -c \
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

# Log the completion of the entire process
echo "STAR alignment process for S58 rerun completed at $(date)" >> ${log_file}
