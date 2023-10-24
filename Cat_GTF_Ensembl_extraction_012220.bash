#BASH script to select chromosome B3 PWS region from Cat annotation and second to select all Ensembl_ID and Gene_name

cat Felis_catus.Felis_catus_9.0.99.gtf  | awk '{ if ($1=="B3") print $_; }' | \
awk '{ if ($3== "gene") print $_; }' | \
awk '{ if ($4 >= 22500000) print $_; }' | \
awk '{ if ($5 <= 25750000) print $_; }' | \
cut -f9 | \
cut -d ";" -f1,3 | \
cut -d \" -f2,4 | \
sed 's/\"/\t/g' > Fcat_PWS_Ensembl.tsv

cat Felis_catus.Felis_catus_9.0.99.gtf  |
awk '{ if ($3== "gene") print $_; }' | \
cut -f9 | \
cut -d ";" -f1,3 | \
cut -d \" -f2,4 | \
sed 's/\"/\t/g' > Fcat_GeneID_Ensembl.tsv
