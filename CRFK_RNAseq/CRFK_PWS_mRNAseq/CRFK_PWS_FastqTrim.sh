#!/bin/bash

# Path to your directory containing FASTQ files
fastq_dir="/Users/koppesea/Documents/Bioinfx/SeqCenter_Aug2024/Illumina_RNA_Reads"
# Output directory for trimmed files
trim_dir="/Users/koppesea/Documents/Bioinfx/Bioinformatics_2024/CRFK_PWS_mRNASeq/FastqTrim"
# Log file to store the echo statements and fastp output
log_file="${trim_dir}/trimming_log.txt"

# Create the output directory if it doesn't exist
mkdir -p ${trim_dir}

# Initialize the log file
echo "Trimming process started at $(date)" > ${log_file}

# Loop through samples S54 to S59
for sample in {54..59}; do
    # Construct file names
    R1_file="${fastq_dir}/EK155_*_S${sample}_R1_001.fastq.gz"
    R2_file="${fastq_dir}/EK155_*_S${sample}_R2_001.fastq.gz"
    
    # Extract base name for output (basename strips directory and extensions)
    base_name=$(basename ${R1_file} _R1_001.fastq.gz)
    
    # Output file names
    trim_R1="${trim_dir}/${base_name}_trimmed_R1.fastq.gz"
    trim_R2="${trim_dir}/${base_name}_trimmed_R2.fastq.gz"
    
    # Log the start of processing for this sample
    echo "Processing ${base_name} started at $(date)" >> ${log_file}
    
    # Run fastp to trim adapters with unique output for JSON and HTML reports
    # Redirect both stdout and stderr to the log file
    fastp -i ${R1_file} -I ${R2_file} -o ${trim_R1} -O ${trim_R2} \
          --json "${trim_dir}/${base_name}_fastp.json" \
          --html "${trim_dir}/${base_name}_fastp.html" \
          >> ${log_file} 2>&1
    
    # Log the completion of processing for this sample
    echo "Processed ${base_name} - trimmed files saved as ${trim_R1} and ${trim_R2}" >> ${log_file}
    echo "Processing ${base_name} completed at $(date)" >> ${log_file}
    echo "----------------------------------------" >> ${log_file}
done

# Log the completion of the entire process
echo "Trimming process completed at $(date)" >> ${log_file}