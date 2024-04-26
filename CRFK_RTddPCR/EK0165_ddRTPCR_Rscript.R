##Script for importing and normalizing EK0165 CRFK ddRT-PCR

library(readr)
library(dplyr)
library(tidyr)
library(tibble)
library(ggplot2)
library(openxlsx)
#install.packages("Hmisc")
library(Hmisc)
library(forcats)

plate1_all <- read_csv("EK0165_ddRTPCR_catPWSICdel_manualthreshold_010819.csv", col_names = T)

plate_1 <- read_csv("EK0165_ddRTPCR_catPWSICdel_manualthreshold_010819.csv", col_names = T) %>%
  select("Well", "Sample", "Target", "Conc(copies/µL)", "Copies/20µLWell", "PoissonConfMax", "PoissonConfMin",
         "Positives", "Negatives", "Accepted Droplets") %>%
  filter(Target != "Ch2")

plate_2 <- read_csv("EK0165_ddRTPCR_plate2_011719_Manual_021720.csv", col_names = T) %>%
  select("Well", "Sample", "Target", "Conc(copies/µL)", "Copies/20µLWell", "PoissonConfMax", "PoissonConfMin",
         "Positives", "Negatives", "Accepted Droplets") %>%
  filter(Target != "Ch2")

plate_3 <- read_csv("EK0165_ddRTPCR_plate3_011819_manual.csv", col_names = T) %>%
  select("Well", "Sample", "Target", "Conc(copies/µL)", "Copies/20µLWell", "PoissonConfMax", "PoissonConfMin",
         "Positives", "Negatives", "Accepted Droplets") %>%
  filter(Target != "Ch2")

plate_4 <- read_csv("EK0165_ddRTPCR_plate4_011819_manual.csv", col_names = T) %>%
  select("Well", "Sample", "Target", "Conc(copies/µL)", "Copies/20µLWell", "PoissonConfMax", "PoissonConfMin",
         "Positives", "Negatives", "Accepted Droplets") %>%
  filter(Target != "Ch2")

plate_5 <- read_csv("EK0165_ddRTPCR_plate5_021119_manual.csv", col_names = T) %>%
  select("Well", "Sample", "Target", "Conc(copies/µL)", "Copies/20µLWell", "PoissonConfMax", "PoissonConfMin",
         "Positives", "Negatives", "Accepted Droplets") %>%
  filter(Target != "Ch2")

colnames(plate_1) <-(c("Well", "Sample", "Target", "Concentration", "CopiesperWell", "PoissonConfMax", "PoissonConfMin",
                       "Positives", "Negatives", "Accepted Droplets"))
colnames(plate_2) <-(c("Well", "Sample", "Target", "Concentration", "CopiesperWell", "PoissonConfMax", "PoissonConfMin",
                       "Positives", "Negatives", "Accepted Droplets"))
colnames(plate_3) <-(c("Well", "Sample", "Target", "Concentration", "CopiesperWell", "PoissonConfMax", "PoissonConfMin",
                       "Positives", "Negatives", "Accepted Droplets"))
colnames(plate_4) <-(c("Well", "Sample", "Target", "Concentration", "CopiesperWell", "PoissonConfMax", "PoissonConfMin",
                       "Positives", "Negatives", "Accepted Droplets"))
colnames(plate_5) <-(c("Well", "Sample", "Target", "Concentration", "CopiesperWell", "PoissonConfMax", "PoissonConfMin",
                       "Positives", "Negatives", "Accepted Droplets"))
plate_1 <- mutate(plate_1, Concentration = as.numeric(plate_1$Concentration))
plate_2 <- mutate(plate_2, Concentration = as.numeric(plate_2$Concentration))
plate_3 <- mutate(plate_3, Concentration = as.numeric(plate_3$Concentration))
plate_4 <- mutate(plate_4, Concentration = as.numeric(plate_4$Concentration))
plate_5 <- mutate(plate_5, Concentration = as.numeric(plate_5$Concentration))

plate_2_lim <- plate_2 %>% filter(!(Target == "Gapdh" | Target == "SNRPN")) %>% select("Sample", "Target", "Concentration", "PoissonConfMax", "PoissonConfMin")
plate_3_lim <- plate_3 %>% filter(Target != "NDN") %>% select("Sample", "Target", "Concentration", "PoissonConfMax", "PoissonConfMin")
plate_4_lim <- plate_4 %>% filter(Target != "IPW") %>% select("Sample", "Target", "Concentration", "PoissonConfMax", "PoissonConfMin")
plate_5_lim <- plate_5 %>% filter(Target != "KLF14") %>% select("Sample", "Target", "Concentration", "PoissonConfMax", "PoissonConfMin")

#gives incorrect order
## Sample_list <- print(plate_2 %>% arrange(Sample) %>% distinct(Sample)) %>% pull(Sample)
#corrected below
Sample_list <- c("Blank", "NTC", "EK165_1", "EK165_2", "EK165_3", "EK165_4", "EK165_5", "EK165_6", "EK165_7", "EK165_8", "EK165_9",
                 "EK165_10", "EK165_11", "EK165_12", "EK165_13", "EK165_14", "EK165_15", "EK165_16", "EK165_17", "EK165_18", "EK165_19",
                 "EK165_20", "EK165_21", "EK165_22") 

Sample_names <- c("Blank", "NTC", "CRFK", "EK155.1.2", "EK155.1.3", "EK155.1.4", "EK155.1.18",
                  "EK155.1.20", "EK155.1.22", "EK155.1.31", "EK155.1.35", "EK155.1.36", "EK155.1.42",
                  "EK155.2.5", "EK155.2.6", "EK155.2.12", "EK155.2.15", "EK155.2.20", "EK155.2.21",
                  "EK155.2.22", "EK155.2.23", "EK155.2.25", "EK155.2.32", "EK155.2.38")
Sample_type <- as_factor("Blank", "NTC", "Control", "PatDel+MatInv/Intact", "PatDel+MatInv/Intact", "MatDel+PatInv/Intact", "MatDel",
                         "Control", "MatDel+PatInv/Intact", "PatDel+MatInv/Intact", )
Sample_conv <- tibble(Sample_list, Sample_names)
colnames(Sample_conv) <- c("Sample", "Sample_names")

allplates <- bind_rows(plate_2_lim, plate_3_lim, plate_4_lim, plate_5_lim)
GAPDH_REF <- plate_3_lim %>% filter(Target == "Gapdh")

allplates_rel <- inner_join(allplates, GAPDH_REF, by = "Sample") %>%
  mutate(rel_gapdh = Concentration.x / Concentration.y)


allplates_abs <- allplates  %>%
  mutate_all(~replace(., is.na(.), 0)) %>%  ##Set NAs to 0%>%
  mutate(copyperng = Concentration * 20/300) %>% ##divide by microliter reaction divided by RNA amount
  mutate(copyperug = copyperng * 1000) %>%
  mutate(pconmaxug = PoissonConfMax * 20/300 * 1000) %>%
  mutate(pconminug = PoissonConfMin * 20/300 * 1000) %>%
  left_join(Sample_conv, by = "Sample") %>%
  mutate(Sample_names = as_factor(Sample_names)) %>%
  mutate(Sample_names = fct_relevel(Sample_names,"Blank", "NTC", "CRFK", "EK155.1.2", "EK155.1.3", "EK155.1.4", "EK155.1.18",
                                                    "EK155.1.20", "EK155.1.22", "EK155.1.31", "EK155.1.35", "EK155.1.36", "EK155.1.42",
                                                    "EK155.2.5", "EK155.2.6", "EK155.2.12", "EK155.2.15", "EK155.2.20", "EK155.2.21",
                                                    "EK155.2.22", "EK155.2.23", "EK155.2.25", "EK155.2.32", "EK155.2.38")) %>%
  mutate(Target = as_factor(Target)) %>%
  mutate(Target = fct_relevel(Target, "Gapdh","MKRN3", "NDN", "SNURF", "SNRPN", "SNORD107", "SNORD64", "SNORD109", "SNORD116", "IPW")) %>%
  mutate(Sample_type =
           if_else(Sample_names == "Blank", "Blank",
           if_else(Sample_names == "NTC", "NTC",
           if_else(Sample_names %in% c("EK155.1.18", "EK155.2.12"), "MatDel",
           if_else(Sample_names %in% c("EK155.2.21", "EK155.2.25"), "PatDel",
           if_else(Sample_names %in% c("EK155.1.35", "EK155.1.36", "EK155.2.6"), "MatInv",
           if_else(Sample_names == "EK155.2.32", "PatInv",
           if_else(Sample_names %in% c("EK155.1.4", "EK155.1.22"), "MatDel+PatInv/Intact",
           if_else(Sample_names %in% c("EK155.1.2", "EK155.1.3", "EK155.1.31", "EK155.1.42"), "PatDel+MatInv/Intact",
           if_else(Sample_names == "EK155.2.38", "HomzDel",
           if_else(Sample_names %in% c("EK155.2.20", "EK155.2.22", "EK155.2.23"), "Complex",
           if_else(Sample_names %in% c("CRFK", "EK155.1.20", "EK155.2.5", "EK155.2.15"), "Control", "TBD"
                   )))))))))))) %>%
  mutate(Sample_type = as_factor(Sample_type)) %>%
  mutate(Sample_type = fct_relevel(Sample_type, "Control", "MatDel", "PatDel", "HomzDel", "MatInv", "PatInv", "MatDel+PatInv/Intact",
                                   "PatDel+MatInv/Intact", "Complex"))
  

allplates_abs <- as_tibble(allplates_abs)

##ggplot w/ Sample order absolute
allplates_abs %>% filter(Sample != "Blank") %>% filter(Sample != "NTC") %>%
ggplot(aes(x = Sample_names, y = copyperug)) +
  geom_col(aes(fill = Sample_type)) +
  scale_fill_brewer(palette = "Set1") +
  theme_bw() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle=45, hjust = 1)) +
  facet_wrap(. ~ Target, ncol =2, scales = "free_y") +
  scale_x_discrete(NULL) +
  labs(fill = "Genotype")

#ggplot w/Sample type order absolute
allplates_abs %>% filter(Sample != "Blank") %>% filter(Sample != "NTC") %>%
mutate(Sample_names = fct_relevel(Sample_names, "CRFK", "EK155.1.20", "EK155.2.5", "EK155.2.15",
                                  "EK155.1.18", "EK155.2.12", "EK155.2.21", "EK155.2.25", "EK155.2.38",
                                  "EK155.1.35", "EK155.1.36", "EK155.2.6", "EK155.2.32",
                                  "EK155.1.4", "EK155.1.22", "EK155.1.2", "EK155.1.3", "EK155.1.31", "EK155.1.42",
                                  "EK155.2.20", "EK155.2.22", "EK155.2.23")) %>%
  ggplot(aes(x = Sample_names, y = copyperug)) +
  geom_col(aes(fill = Sample_type)) +
  scale_fill_brewer(palette = "Set1") +
  theme_bw() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle=45, hjust = 1)) +
  facet_wrap(. ~ Target, ncol =2, scales = "free_y") +
  scale_x_discrete(NULL) +
  labs(fill = "Genotype")


rel_gapdh_CRFK <- allplates_rel %>% filter(Sample == "EK165_1") %>% filter(Target.x != "Gapdh") %>% select(Target.x, rel_gapdh)
rel_gapdh_CRFK <- column_to_rownames(rel_gapdh_CRFK, "Target.x")

allplates_rel_fin <- allplates_rel %>%
  arrange(Target.x, Sample) %>%
  filter(Sample != "Blank") %>%
  filter(Target.x != "Gapdh")  %>%
  left_join(Sample_conv, by = "Sample") %>%
  mutate(Sample_names = as_factor(Sample_names)) %>%
  mutate(Sample_names = fct_relevel(Sample_names,"CRFK", "EK155.1.2", "EK155.1.3", "EK155.1.4", "EK155.1.18",
                                    "EK155.1.20", "EK155.1.22", "EK155.1.31", "EK155.1.35", "EK155.1.36", "EK155.1.42",
                                    "EK155.2.5", "EK155.2.6", "EK155.2.12", "EK155.2.15", "EK155.2.20", "EK155.21",
                                    "EK155.2.22", "EK155.2.23", "EK155.2.25", "EK155.2.32", "EK155.2.38", "NTC")) %>%
  mutate(rel_CRFK_gapdh_ref = 
           if_else(Target.x == "IPW", rel_gapdh/rel_gapdh_CRFK["IPW","rel_gapdh"],
           if_else(Target.x == "MKRN3", rel_gapdh/rel_gapdh_CRFK["MKRN3","rel_gapdh"],
           if_else(Target.x == "NDN", rel_gapdh/rel_gapdh_CRFK["NDN","rel_gapdh"],
           if_else(Target.x == "SNORD107", rel_gapdh/rel_gapdh_CRFK["SNORD107","rel_gapdh"],
           if_else(Target.x == "SNORD109", rel_gapdh/rel_gapdh_CRFK["SNORD109","rel_gapdh"],
           if_else(Target.x == "SNORD116", rel_gapdh/rel_gapdh_CRFK["SNORD116","rel_gapdh"],
           if_else(Target.x == "SNORD64", rel_gapdh/rel_gapdh_CRFK["SNORD64","rel_gapdh"],
           if_else(Target.x == "SNORD109", rel_gapdh/rel_gapdh_CRFK["SNORD109","rel_gapdh"],
           if_else(Target.x == "SNRPN", rel_gapdh/rel_gapdh_CRFK["SNRPN","rel_gapdh"],
                   rel_gapdh/rel_gapdh_CRFK["SNURF","rel_gapdh"],
           )))))))))) %>%
  mutate(Target.x = as_factor(Target.x)) %>%
  mutate(Target.x = fct_relevel(Target.x, "SNURF", "SNRPN", "SNORD107", "SNORD64", "SNORD109", "SNORD116", "IPW", "NDN", "MKRN3"))

##have to remove NTC
allplates_rel_fin %>% filter(Sample_names != "NTC") %>%
  ggplot(aes(x = Sample_names, y = rel_CRFK_gapdh_ref)) +
  geom_col() +
  scale_fill_brewer(palette = "Set1") +
  theme_bw() +
  theme(legend.position = "Right",
        axis.text.x = element_text(angle=45, hjust = 1)) +
  facet_wrap(. ~ Target.x, ncol =3, scales = "free_y") +
  scale_x_discrete(NULL)

