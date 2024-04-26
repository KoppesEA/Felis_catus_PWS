##script to analyze Cat PWS-IC bisulfite PCR Ampliconseq


library(openxlsx)
library(dplyr)
library(stringr)
library(ggplot2)

EK01_import <- read.xlsx("Plate1_abundance.xlsx", sheet = 1)

EK02_import <- read.xlsx("Plate1_abundance.xlsx", sheet = 2)

EKCRFK_import <- rbind(EK01_import, EK02_import)

meTemplate <- tibble(TargetSequence = "GGAATCGAGAATAATTTTTTTAATATTTTACGTGTTTTAAAAAAGAGAGATTTTGTTATTAAATTTAGGGTGGTGGTGGAGTTTTTAAAAGGCGTTAGCGTTTTGGTTATTTGTAGTGTAGTAGAAATTAGGTTTTAACGATTTCGTTTGGCGGGGGCGTTGGTATTTTTGTATTGCGGTAGGATTTTAGTATTGCGGTAAATAGTTGCGGTTGCGTAGTTAAAGTCGGAGGGGTGGCGAGTTGCGTATGCGTAGGTGGAATTGGTGTGATTAGTTTTGTCGTAGTGATTGGAATATAGAGTGGAGTGGTCGTCGGAGATGTTTGAAGGTTTGTTTTGAGGAGCGGTTAGTAGCGCGATGGAGCGGGTTAGGTTAGTTGTGTGGATGTTTTTTTTTAGAGATAGTTTA"
) %>% select(TargetSequence) %>%
  mutate(CG_counts = str_count(TargetSequence, "CG")) %>%
  mutate(CG_pos = str_locate_all(TargetSequence, "C"))
meTemplate$CG_pos ##to see the 23 CG positions

EK01_me <- EK01_import %>% select(TargetSequence) %>%
  mutate(CG_counts = str_count(TargetSequence, "CG")) %>%
  mutate(CG_pos = str_locate_all(TargetSequence, "C")) %>%  ##lists with start/end
  mutate(pos_006 = if_else(str_detect(CG_pos, "6"), 1, 0)) %>%
  mutate(pos_031 = if_else(str_detect(CG_pos, "31"), 1, 0)) %>%
  mutate(pos_093 = if_else(str_detect(CG_pos, "93"), 1, 0)) %>%
  mutate(pos_099 = if_else(str_detect(CG_pos, "99"), 1, 0)) %>%
  mutate(pos_139 = if_else(str_detect(CG_pos, "139"), 1, 0)) %>%
  mutate(pos_145 = if_else(str_detect(CG_pos, "145"), 1, 0)) %>%
  mutate(pos_152 = if_else(str_detect(CG_pos, "152"), 1, 0)) %>%
  mutate(pos_158 = if_else(str_detect(CG_pos, "158"), 1, 0)) %>%
  mutate(pos_177 = if_else(str_detect(CG_pos, "177"), 1, 0)) %>%
  mutate(pos_196 = if_else(str_detect(CG_pos, "196"), 1, 0)) %>%
  mutate(pos_209 = if_else(str_detect(CG_pos, "209"), 1, 0)) %>%
  mutate(pos_215 = if_else(str_detect(CG_pos, "215"), 1, 0)) %>%
  mutate(pos_227 = if_else(str_detect(CG_pos, "227"), 1, 0)) %>%
  mutate(pos_238 = if_else(str_detect(CG_pos, "238"), 1, 0)) %>%
  mutate(pos_245 = if_else(str_detect(CG_pos, "245"), 1, 0)) %>%
  mutate(pos_251 = if_else(str_detect(CG_pos, "251"), 1, 0)) %>%
  mutate(pos_281 = if_else(str_detect(CG_pos, "281"), 1, 0)) %>%
  mutate(pos_311 = if_else(str_detect(CG_pos, "311"), 1, 0)) %>%
  mutate(pos_314 = if_else(str_detect(CG_pos, "314"), 1, 0)) %>%
  mutate(pos_344 = if_else(str_detect(CG_pos, "344"), 1, 0)) %>%
  mutate(pos_354 = if_else(str_detect(CG_pos, "354"), 1, 0)) %>%
  mutate(pos_356 = if_else(str_detect(CG_pos, "356"), 1, 0)) %>%
  mutate(pos_364 = if_else(str_detect(CG_pos, "364"), 1, 0))
#  23 warning for coercing list to vector

EK02_me <- EK02_import %>% select(TargetSequence) %>%
  mutate(CG_counts = str_count(TargetSequence, "CG")) %>%
  mutate(CG_pos = str_locate_all(TargetSequence, "C")) %>%  ##lists with start/end
  mutate(pos_006 = if_else(str_detect(CG_pos, "6"), 1, 0)) %>%
  mutate(pos_031 = if_else(str_detect(CG_pos, "31"), 1, 0)) %>%
  mutate(pos_093 = if_else(str_detect(CG_pos, "93"), 1, 0)) %>%
  mutate(pos_099 = if_else(str_detect(CG_pos, "99"), 1, 0)) %>%
  mutate(pos_139 = if_else(str_detect(CG_pos, "139"), 1, 0)) %>%
  mutate(pos_145 = if_else(str_detect(CG_pos, "145"), 1, 0)) %>%
  mutate(pos_152 = if_else(str_detect(CG_pos, "152"), 1, 0)) %>%
  mutate(pos_158 = if_else(str_detect(CG_pos, "158"), 1, 0)) %>%
  mutate(pos_177 = if_else(str_detect(CG_pos, "177"), 1, 0)) %>%
  mutate(pos_196 = if_else(str_detect(CG_pos, "196"), 1, 0)) %>%
  mutate(pos_209 = if_else(str_detect(CG_pos, "209"), 1, 0)) %>%
  mutate(pos_215 = if_else(str_detect(CG_pos, "215"), 1, 0)) %>%
  mutate(pos_227 = if_else(str_detect(CG_pos, "227"), 1, 0)) %>%
  mutate(pos_238 = if_else(str_detect(CG_pos, "238"), 1, 0)) %>%
  mutate(pos_245 = if_else(str_detect(CG_pos, "245"), 1, 0)) %>%
  mutate(pos_251 = if_else(str_detect(CG_pos, "251"), 1, 0)) %>%
  mutate(pos_281 = if_else(str_detect(CG_pos, "281"), 1, 0)) %>%
  mutate(pos_311 = if_else(str_detect(CG_pos, "311"), 1, 0)) %>%
  mutate(pos_314 = if_else(str_detect(CG_pos, "314"), 1, 0)) %>%
  mutate(pos_344 = if_else(str_detect(CG_pos, "344"), 1, 0)) %>%
  mutate(pos_354 = if_else(str_detect(CG_pos, "354"), 1, 0)) %>%
  mutate(pos_356 = if_else(str_detect(CG_pos, "356"), 1, 0)) %>%
  mutate(pos_364 = if_else(str_detect(CG_pos, "364"), 1, 0))

EKCRFK_me <- EKCRFK_import %>% select(TargetSequence) %>%
  mutate(CG_counts = str_count(TargetSequence, "CG")) %>%
  mutate(CG_pos = str_locate_all(TargetSequence, "C")) %>%  ##lists with start/end
  mutate(pos_006 = if_else(str_detect(CG_pos, "6"), 1, 0)) %>%
  mutate(pos_031 = if_else(str_detect(CG_pos, "31"), 1, 0)) %>%
  mutate(pos_093 = if_else(str_detect(CG_pos, "93"), 1, 0)) %>%
  mutate(pos_099 = if_else(str_detect(CG_pos, "99"), 1, 0)) %>%
  mutate(pos_139 = if_else(str_detect(CG_pos, "139"), 1, 0)) %>%
  mutate(pos_145 = if_else(str_detect(CG_pos, "145"), 1, 0)) %>%
  mutate(pos_152 = if_else(str_detect(CG_pos, "152"), 1, 0)) %>%
  mutate(pos_158 = if_else(str_detect(CG_pos, "158"), 1, 0)) %>%
  mutate(pos_177 = if_else(str_detect(CG_pos, "177"), 1, 0)) %>%
  mutate(pos_196 = if_else(str_detect(CG_pos, "196"), 1, 0)) %>%
  mutate(pos_209 = if_else(str_detect(CG_pos, "209"), 1, 0)) %>%
  mutate(pos_215 = if_else(str_detect(CG_pos, "215"), 1, 0)) %>%
  mutate(pos_227 = if_else(str_detect(CG_pos, "227"), 1, 0)) %>%
  mutate(pos_238 = if_else(str_detect(CG_pos, "238"), 1, 0)) %>%
  mutate(pos_245 = if_else(str_detect(CG_pos, "245"), 1, 0)) %>%
  mutate(pos_251 = if_else(str_detect(CG_pos, "251"), 1, 0)) %>%
  mutate(pos_281 = if_else(str_detect(CG_pos, "281"), 1, 0)) %>%
  mutate(pos_311 = if_else(str_detect(CG_pos, "311"), 1, 0)) %>%
  mutate(pos_314 = if_else(str_detect(CG_pos, "314"), 1, 0)) %>%
  mutate(pos_344 = if_else(str_detect(CG_pos, "344"), 1, 0)) %>%
  mutate(pos_354 = if_else(str_detect(CG_pos, "354"), 1, 0)) %>%
  mutate(pos_356 = if_else(str_detect(CG_pos, "356"), 1, 0)) %>%
  mutate(pos_364 = if_else(str_detect(CG_pos, "364"), 1, 0))

ggplot(EK01_me, aes(x = CG_counts)) +
  geom_histogram(bins = 23, binwidth = 1, fill = "blue", color = "black") +
  scale_x_continuous(limits = c(-1,23), breaks = c(0:23)) +
  labs(x = "CG Counts",
       y = "Amplicon Read Counts")

ggplot(EK02_me, aes(x = CG_counts)) +
  geom_histogram(bins = 23, binwidth = 1, fill = "blue", color = "black") +
  scale_x_continuous(limits = c(-1,23), breaks = c(0:23)) +
  labs(x = "CG Counts",
       y = "Amplicon Read Counts")

ggplot(EKCRFK_me, aes(x = CG_counts)) +
  geom_histogram(bins = 23, binwidth = 1, fill = "blue", color = "black") +
  scale_x_continuous(limits = c(-1,23), breaks = c(0:23)) +
  labs(x = "CG Counts",
       y = "Amplicon Read Counts")

##summary for each CpG

summary_01 <- EK01_me %>% select(-c(1:3)) %>%
  summarise_all(mean)

#E_countsummary_01 <- EK01_me %>% select(-c(1:3)) %>%
#  summarise_all(methylatonperc = mean)

summary_02 <- EK02_me %>% select(-c(1:3)) %>%
  summarise_all(mean)

summary_CRFK <- EKCRFK_me %>% select(-c(1:3)) %>%
  summarise_all(mean)

##use summary to graph methylation fraction acorss positions
sites <- as.vector(colnames(summary_01))
averages <- as.numeric(summary_01[1,])
EK01_sum <- cbind(sites, averages) %>%
  as_tibble() %>%
  mutate(averages = as.numeric(averages)) %>%
  mutate(bin = if_else(averages < 0.10, "< 10%",
                       if_else(0.10 <= averages & averages < 0.20, "10-20%",
                               if_else(0.20 <= averages & averages < 0.30, "20-30%",
                                       if_else(0.30 <= averages & averages < 0.40, "30-40%",
                                               if_else(0.40 <= averages & averages < 0.50, "40-50%",
                                                       if_else(0.50 <= averages & averages < 0.60, "50-60%",
                                                               if_else(0.60 <= averages & averages < 0.70, "60-70%",
                                                                       if_else(0.70 <= averages & averages < 0.80, "70-80%",
                                                                               if_else(0.80 <= averages & averages < 0.90, "80-90%",
                                                                                       if_else(0.90 <= averages & averages < 1.0, "90-100%",
                                                                                               "whoa")))))))))))
EK01_sum %>%
  ggplot(aes(x = sites, y = averages)) +
  geom_col(fill = "green", color = "black") +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(x = "Feline PWS-IC CpG Site Position",
       y = "CpG methylation Fraction")

##same for EK02
sites_2 <- as.vector(colnames(summary_02))
averages <- as.numeric(summary_02[1,])
EK02_sum <- cbind(sites, averages) %>%
  as_tibble() %>%
  mutate(averages = as.numeric(averages)) %>%
  mutate(bin = if_else(averages < 0.10, "< 10%",
                       if_else(0.10 <= averages & averages < 0.20, "10-20%",
                               if_else(0.20 <= averages & averages < 0.30, "20-30%",
                                       if_else(0.30 <= averages & averages < 0.40, "30-40%",
                                               if_else(0.40 <= averages & averages < 0.50, "40-50%",
                                                       if_else(0.50 <= averages & averages < 0.60, "50-60%",
                                                               if_else(0.60 <= averages & averages < 0.70, "60-70%",
                                                                       if_else(0.70 <= averages & averages < 0.80, "70-80%",
                                                                               if_else(0.80 <= averages & averages < 0.90, "80-90%",
                                                                                       if_else(0.90 <= averages & averages < 1.0, "90-100%",
                                                                                               "whoa")))))))))))
EK02_sum %>%
  ggplot(aes(x = sites, y = averages)) +
  geom_col(fill = "green", color = "black") +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(x = "Feline PWS-IC CpG Site Position",
       y = "CpG methylation Fraction")

##same for EKCRFK
sites_2 <- as.vector(colnames(summary_CRFK))
averages <- as.numeric(summary_CRFK[1,])
EKCRFK_sum <- cbind(sites, averages) %>%
  as_tibble() %>%
  mutate(averages = as.numeric(averages)) %>%
  mutate(bin = if_else(averages < 0.10, "< 10%",
                       if_else(0.10 <= averages & averages < 0.20, "10-20%",
                               if_else(0.20 <= averages & averages < 0.30, "20-30%",
                                       if_else(0.30 <= averages & averages < 0.40, "30-40%",
                                               if_else(0.40 <= averages & averages < 0.50, "40-50%",
                                                       if_else(0.50 <= averages & averages < 0.60, "50-60%",
                                                               if_else(0.60 <= averages & averages < 0.70, "60-70%",
                                                                       if_else(0.70 <= averages & averages < 0.80, "70-80%",
                                                                               if_else(0.80 <= averages & averages < 0.90, "80-90%",
                                                                                       if_else(0.90 <= averages & averages < 1.0, "90-100%",
                                                                                               "whoa")))))))))))
EKCRFK_sum %>%
  ggplot(aes(x = sites, y = averages)) +
  geom_col(fill = "green", color = "black") +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(x = "Feline PWS-IC CpG Site Position",
       y = "CpG methylation Fraction")


CRFK_ampliconseq <- createWorkbook("CRFK_ampliconseq")
addWorksheet(CRFK_ampliconseq, "EK01_CRFK")
writeData(CRFK_ampliconseq, "EK01_CRFK", EK01_sum, rowNames = F, colNames = T)
addWorksheet(CRFK_ampliconseq, "EK02_CRFK")
writeData(CRFK_ampliconseq, "EK02_CRFK", EK02_sum, rowNames = F, colNames = T)
saveWorkbook(CRFK_ampliconseq, "CRFK_ampliconseq.xlsx", overwrite = T)
