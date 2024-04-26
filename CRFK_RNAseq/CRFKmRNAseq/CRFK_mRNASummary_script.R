library(readr)
library(dplyr)
library(tidyr)
library(forcats)
library(openxlsx)

UnionAll_All <- read_csv("CRFK_CPV_mRNA_all_wNormcounts_UnionAll.csv")
UnionNone_All <- read_csv("CRFK_CPV_mRNA_all_wNormcounts_UnionNone.csv")
UnionAll_padj <- read_csv("CRFK_CPV_mRNA_padj_wNormcounts_UnionAll.csv")
UnionNone_padj <- read_csv("CRFK_CPV_mRNA_padj_wNormcounts_UnionNone.csv")

Cat_PWS <- read_tsv("Fcat_PWS_Ensembl.tsv", col_names = c("gene_ID", "gene_name"))

UnionAll_PWS <- UnionAll_All %>% filter(gene_ID %in% Cat_PWS$gene_ID) %>% arrange(desc(baseMean))
UnionNone_PWS <- UnionNone_All %>% filter(gene_ID %in% Cat_PWS$gene_ID) %>% arrange(desc(baseMean))

UnionAll_top250 <- UnionAll_All %>%
  arrange(desc(baseMean)) %>%
  top_n(250, baseMean)

UnionNone_top250 <- UnionAll_All %>%
  arrange(desc(baseMean)) %>%
  top_n(250, baseMean)

#Create Excel Table of 
CRFK_mRNA_summary <- createWorkbook("CRFK_mRNA_summary")
addWorksheet(CRFK_mRNA_summary, "Union_All_All")
writeData(CRFK_mRNA_summary, "Union_All_All", UnionAll_All, rowNames = F, colNames = T)
addWorksheet(CRFK_mRNA_summary, "UnionAll_250")
writeData(CRFK_mRNA_summary, "UnionAll_250", UnionAll_top250, rowNames = F, colNames = T)
addWorksheet(CRFK_mRNA_summary, "UnionAll_PWS")
writeData(CRFK_mRNA_summary, "UnionAll_PWS", UnionAll_PWS, rowNames = F, colNames = T)
addWorksheet(CRFK_mRNA_summary, "UnionAll_padj")
writeData(CRFK_mRNA_summary, "UnionAll_padj", UnionAll_padj, rowNames = F, colNames = T)
addWorksheet(CRFK_mRNA_summary, "Union_None_All")
writeData(CRFK_mRNA_summary, "Union_None_All", UnionAll_All, rowNames = F, colNames = T)
addWorksheet(CRFK_mRNA_summary, "UnionNone_250")
writeData(CRFK_mRNA_summary, "UnionNone_250", UnionAll_top250, rowNames = F, colNames = T)
addWorksheet(CRFK_mRNA_summary, "UnionNone_PWS")
writeData(CRFK_mRNA_summary, "UnionNone_PWS", UnionAll_PWS, rowNames = F, colNames = T)
addWorksheet(CRFK_mRNA_summary, "UnionNone_padj")
writeData(CRFK_mRNA_summary, "UnionNone_padj", UnionAll_padj, rowNames = F, colNames = T)

saveWorkbook(CRFK_mRNA_summary, "CRFK_mRNA_summary.xlsx", overwrite = T)