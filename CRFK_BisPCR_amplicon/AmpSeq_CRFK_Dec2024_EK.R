## Erik Koppes, PhD
## Postdoctoral Associate, RD Nicholls Lab
## University of Pittsburgh Dept of Genetic and Genomic Medicine
## Sept 3rd, 2020; Revised December 2024
## Script to analyze Cat PWS-IC bisulfite PCR Ampliconseq

# Load Dependencies
library(openxlsx)
library(dplyr)
library(purrr)
library(stringr)
library(tidyr)
library(ggplot2)

# Import "Plate Abundance" files from genewiz that give DNA sequence and # of reads
# Function to import and process plate abundance data
import_plate_abundance <- function(file_name, sheet = 1, import_dir = "./ReadAbundance/") {
  # Construct the file path
  file_path <- paste0(import_dir, file_name)
  # Read the Excel file and select required columns
  abundance_data <- read.xlsx(file_path, sheet = sheet) %>%
    select(TargetSequence, Reads, AvgQScore, Type, Pct)
  return(abundance_data)
}

# Excel Import
EK01_import <- import_plate_abundance("Plate1_abundance.xlsx", sheet = 1)
EK02_import <- import_plate_abundance("Plate1_abundance.xlsx", sheet = 2)
EKCRFK_import <- rbind(EK01_import, EK02_import)
EK11_import <- import_plate_abundance("Plate2_abundance.xlsx", sheet = 1)
EK12_import <- import_plate_abundance("Plate2_abundance.xlsx", sheet = 2)
EK13_import <- import_plate_abundance("Plate2_abundance.xlsx", sheet = 3)

## Define 23 CpG Dinucleotide positions

meTemplate <- tibble(TargetSequence = "GGAATCGAGAATAATTTTTTTAATATTTTACGTGTTTTAAAAAAGAGAGATTTTGTTATTAAATTTAGGGTGGTGGTGGAGTTTTTAAAAGGCGTTAGCGTTTTGGTTATTTGTAGTGTAGTAGAAATTAGGTTTTAACGATTTCGTTTGGCGGGGGCGTTGGTATTTTTGTATTGCGGTAGGATTTTAGTATTGCGGTAAATAGTTGCGGTTGCGTAGTTAAAGTCGGAGGGGTGGCGAGTTGCGTATGCGTAGGTGGAATTGGTGTGATTAGTTTTGTCGTAGTGATTGGAATATAGAGTGGAGTGGTCGTCGGAGATGTTTGAAGGTTTGTTTTGAGGAGCGGTTAGTAGCGCGATGGAGCGGGTTAGGTTAGTTGTGTGGATGTTTTTTTTTAGAGATAGTTTA"
) %>% select(TargetSequence) %>%
  mutate(CG_counts = str_count(TargetSequence, "CG")) %>%
  mutate(CG_pos = str_locate_all(TargetSequence, "CG"))
meTemplate$CG_pos[[1]][, "start"] ##to see the 23 CG positions

# Create output directory if it doesn't exist
if (!dir.exists("./output_png")) {
  dir.create("./output_png")
}

# Updated function to process CpG data with dynamic naming and plotting
process_CpG_data <- function(Amplicondata, positions = meTemplate$CG_pos[[1]][, "start"]) {
  # Extract the base name of the input dataframe
  base_name <- deparse(substitute(Amplicondata)) %>%
    str_extract("^[A-Za-z0-9]{4}")
  
  # Process the Amplicondata
  Amplicondata_counts <- Amplicondata %>%
    select(TargetSequence, Reads) %>%
    filter(!is.na(TargetSequence), !is.na(Reads)) %>%  # Remove NA rows
    mutate(
      CG_counts = str_count(TargetSequence, "CG"),
      CG_pos = map(TargetSequence, ~ str_locate_all(.x, "CG")[[1]][, "start"]) # Extract 'start' positions
    )
  
  # Dynamically create the position columns
  for (pos in positions) {
    pos_col <- paste0("pos_", sprintf("%03d", pos)) # Format as `pos_XXX`
    Amplicondata_counts <- Amplicondata_counts %>%
      mutate(!!pos_col := map_lgl(CG_pos, ~ pos %in% .x)) # Check if the position exists in start positions
  }
  
  # Add columns for CpG reads for each position
  Amplicondata_counts <- Amplicondata_counts %>%
    mutate(across(starts_with("pos_"), ~ . * Reads, .names = "{.col}_reads")) # Multiply boolean by Reads
  
  # Summarize fraction of reads with CpG at each position
  total_reads <- sum(Amplicondata_counts$Reads)
  summary_table <- Amplicondata_counts %>%
    summarise(across(ends_with("_reads"), sum, .names = "sum_{.col}")) %>%
    pivot_longer(cols = everything(), names_to = "Position", values_to = "ReadsWithCpG") %>%
    mutate(
      Position = gsub("^sum_pos_(\\d+)_reads$", "pos_\\1", Position), # Clean up column names
      FractionReadsWithCpG = ReadsWithCpG / total_reads
    )
  
  # Create CG counts histogram with improved error handling
  p <- ggplot(Amplicondata_counts, aes(x = CG_counts)) +
    geom_histogram(bins = 23, binwidth = 1, fill = "blue", color = "black", na.rm = TRUE) +
    scale_x_continuous(limits = c(-1, 23), breaks = c(0:23), oob = scales::squish) +
    labs(
      title = paste(base_name, "CG Counts"),
      x = "CG Counts",
      y = "Amplicon Read Counts"
    ) +
    theme_minimal()
  
  # Save the plot in output_png folder
  ggsave(
    filename = file.path("./output_png", paste0(base_name, "_mecounts.png")), 
    plot = p, 
    width = 8, 
    height = 6, 
    dpi = 300
  )
  
  # Create summary for methylation fraction
  summary_me <- summary_table %>%
    mutate(
      site = Position,
      averages = FractionReadsWithCpG,
      bin = case_when(
        averages < 0.10 ~ "< 10%",
        averages < 0.20 ~ "10-20%",
        averages < 0.30 ~ "20-30%",
        averages < 0.40 ~ "30-40%",
        averages < 0.50 ~ "40-50%",
        averages < 0.60 ~ "50-60%",
        averages < 0.70 ~ "60-70%",
        averages < 0.80 ~ "70-80%",
        averages < 0.90 ~ "80-90%",
        averages <= 1.0 ~ "90-100%",
        TRUE ~ "ERROR"
      )
    )
  
  # Create methylation fraction plot
  p_me <- summary_me %>%
    ggplot(aes(x = site, y = averages)) +
    geom_col(fill = "green", color = "black") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90)) +
    labs(
      title = paste(base_name, "Methylation Fraction"),
      x = "Feline PWS-IC CpG Site Position",
      y = "CpG Methylation Fraction"
    )
  
  # Save the methylation fraction plot in output_png folder
  ggsave(
    filename = file.path("./output_png", paste0(base_name, "_methylation.png")), 
    plot = p_me, 
    width = 10, 
    height = 6, 
    dpi = 300
  )
  
  # Dynamically create result object name
  result_name <- paste0(base_name, "_results")
  assign(result_name, 
         list(
           processed_data = Amplicondata_counts, 
           summary = summary_table,
           summary_me = summary_me
         ), 
         envir = .GlobalEnv)
  
  # Return the result
  return(get(result_name))
}

# Update processing calls
result_EK01 <- process_CpG_data(EK01_import)
result_EK02 <- process_CpG_data(EK02_import)
result_EKCRFK <- process_CpG_data(EKCRFK_import)
result_EK11 <- process_CpG_data(EK11_import)
result_EK12 <- process_CpG_data(EK12_import)
result_EK13 <- process_CpG_data(EK13_import)

