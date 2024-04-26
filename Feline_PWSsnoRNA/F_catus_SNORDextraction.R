##script to import .gtf and then extract Snord115 and Snor116 sequences
##Erik Koppes 3/9/20

library(tidyverse)

##Extracting GTF
F_catus_gtf <- read_tsv("Felis_catus.Felis_catus_9.0.99.gtf",
                        comment = "#",
         col_names = c("seqname", "source", "feature", "start", "end",
                       "score", "strand", "frame", "attribute"))
F_Catus_gtf_1 <- F_catus_gtf %>% separate(attribute, letters[1:15], sep = ";")

##Extracting SNORD115 gene
F_Catus_gtf_SNORD115 <- F_Catus_gtf_1[str_detect(F_Catus_gtf_1$c, pattern = fixed("SNORD115")),] %>%
  select(seqname, start, end, strand, a , c) %>%
  mutate(to_print = str_c(seqname, ":", start, "-", end, sep =""))

write_csv(F_Catus_gtf_SNORD115, "F_Catus_gtf_SNORD115.csv")

F_Catus_gtf_SNORD115 %>% select(to_print) %>%
  write_tsv("F_catus_SNORD115.tsv", col_names = F)

##use below cmd line w/ samtools to extract
#samtools faidx -o F_catus_6.0_SNORD115.fa Felis_catus.Felis_catus_9.0.dna.toplevel.fa F_catus_SNORD115.tsv


#dont't need below as all are on + strand
F_Catus_gtf_SNORD115_plus %>% F_Catus_gtf_SNORD115_3 %>% filter(strand == "+")
F_Catus_gtf_SNORD115_minus %>% F_Catus_gtf_SNORD115_3 %>% filter(strand == "+")


F_Catus_gtf_SNORD115_4 <- F_Catus_gtf_SNORD115 %>%
  mutate(to_print = str_c(seqname, ":", start, end, sep ="")) %>%
  mutate(to_print = str_c(seqname, ":", start, end, sep =""))
  
    mutate(samtools = if_else(strand == "+",
           str_c("samtools faidx -o Felis_catus.Felis_catus_9.0.dna.toplevel.fa",
                          to_print,)

##Extracting SNORD116
F_Catus_gtf_SNORD116 <- F_Catus_gtf_1[str_detect(F_Catus_gtf_1$c, pattern = fixed("SNORD116")),] %>%
  select(seqname, start, end, strand, a, c) %>%
  mutate(to_print = str_c(seqname, ":", start, "-", end, sep =""))

write_csv(F_Catus_gtf_SNORD116, "F_Catus_gtf_SNORD116.csv")

F_Catus_gtf_SNORD116 %>% select(to_print) %>%
  write_tsv("F_catus_SNORD116.tsv", col_names = F)
