## transfering genewiz ampliconseq data
##login into pitt CRC and move to folder to download

sftp robert_nicholls_chp@sftp.genewiz.com
pw: PUfSLOxwbcJp0BoYm2ZR

Connected to sftp.genewiz.com.
sftp> ls
30-404726666    30-424840508
sftp> cd 30-424840508
sftp> ls
00_fastq     01_analysis
sftp> cd 00_fastq/
sftp> ls
EK0239A11_S1_L001_R1_001.fastq.gz       EK0239A11_S1_L001_R2_001.fastq.gz
EK0239A12_S2_L001_R1_001.fastq.gz       EK0239A12_S2_L001_R2_001.fastq.gz
EK0239A13_S3_L001_R1_001.fastq.gz       EK0239A13_S3_L001_R2_001.fastq.gz
md5sum_list.txt
sftp> cd ..
sftp> ls
00_fastq     01_analysis
sftp> pwd
Remote working directory: /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508

##use get -r to download all files in the folder
sftp> get -r ../30-424840508/
Fetching /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508/../30-424840508/ to 30-424840508
Retrieving /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508
Retrieving /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508/01_analysis
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%   53KB 272.2KB/s   00:00
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%   16MB  10.5MB/s   00:01
Retrieving /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508/00_fastq
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%   17MB  12.8MB/s   00:01
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%   19MB  15.1MB/s   00:01
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%   17MB  15.1MB/s   00:01
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%   18MB  18.9MB/s   00:00
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100% 2830KB   6.3MB/s   00:00
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100% 2992KB   5.8MB/s   00:00
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%  408     7.6KB/s   00:00
sftp> cd ..
sftp> ls
30-404726666    30-424840508
sftp> cd 30-424840508
sftp> ls
00_fastq     01_analysis
sftp> cd 0
00_fastq/       01_analysis/
sftp> cd 00_fastq/
sftp> ls
EK0239A11_S1_L001_R1_001.fastq.gz       EK0239A11_S1_L001_R2_001.fastq.gz
EK0239A12_S2_L001_R1_001.fastq.gz       EK0239A12_S2_L001_R2_001.fastq.gz
EK0239A13_S3_L001_R1_001.fastq.gz       EK0239A13_S3_L001_R2_001.fastq.gz
md5sum_list.txt

##mget directly downloaded just the fastq files in the fastq00 folder
sftp> mget *
Fetching /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508/00_fastq/EK0239A11_S1_L001_R1_001.fastq.gz to EK0239A11_S1_L001_R1_001.fastq.gz
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%   17MB  11.7MB/s   00:01
Fetching /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508/00_fastq/EK0239A11_S1_L001_R2_001.fastq.gz to EK0239A11_S1_L001_R2_001.fastq.gz
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%   19MB  17.3MB/s   00:01
Fetching /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508/00_fastq/EK0239A12_S2_L001_R1_001.fastq.gz to EK0239A12_S2_L001_R1_001.fastq.gz
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%   17MB  13.4MB/s   00:01
Fetching /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508/00_fastq/EK0239A12_S2_L001_R2_001.fastq.gz to EK0239A12_S2_L001_R2_001.fastq.gz
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%   18MB  10.5MB/s   00:01
Fetching /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508/00_fastq/EK0239A13_S3_L001_R1_001.fastq.gz to EK0239A13_S3_L001_R1_001.fastq.gz
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100% 2830KB   2.6MB/s   00:01
Fetching /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508/00_fastq/EK0239A13_S3_L001_R2_001.fastq.gz to EK0239A13_S3_L001_R2_001.fastq.gz
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100% 2992KB   5.1MB/s   00:00
Fetching /genewiz-us-ngs-sftp/robert_nicholls_chp/30-424840508/00_fastq/md5sum_list.txt to md5sum_list.txt
/genewiz-us-ngs-sftp/robert_nicholls_chp/30-4 100%  408     7.7KB/s   00:00

sftp> quit
[eak37@login0b AmpliconSeq]$ pwd
/bgfs/rnicholls/Cat_CRFK/AmpliconSeq
[eak37@login0b AmpliconSeq]$ ls
30-424840508                       EK0239A1_R2_001.fastq.gz
EK0239A11_S1_L001_R1_001.fastq.gz  EK0239A2_R1_001.fastq.gz
EK0239A11_S1_L001_R2_001.fastq.gz  EK0239A2_R2_001.fastq.gz
EK0239A12_S2_L001_R1_001.fastq.gz  Genotyper_Results_Instructions.pdf
EK0239A12_S2_L001_R2_001.fastq.gz  md5sum_list.txt
EK0239A13_S3_L001_R1_001.fastq.gz  ref0-results.zip
EK0239A13_S3_L001_R2_001.fastq.gz  results
EK0239A1_R1_001.fastq.gz
[eak37@login0b AmpliconSeq]$ ls -lthF
total 71M
-rwxr-----+ 1 eak37 rnicholls 3.0M Oct 22 12:04 EK0239A13_S3_L001_R2_001.fastq.g                                                                                                                                                             z*
-rwxr-----+ 1 eak37 rnicholls  408 Oct 22 12:04 md5sum_list.txt*
-rwxr-----+ 1 eak37 rnicholls 2.8M Oct 22 12:04 EK0239A13_S3_L001_R1_001.fastq.g                                                                                                                                                             z*
-rwxr-----+ 1 eak37 rnicholls  19M Oct 22 12:04 EK0239A12_S2_L001_R2_001.fastq.g                                                                                                                                                             z*
-rwxr-----+ 1 eak37 rnicholls  17M Oct 22 12:04 EK0239A12_S2_L001_R1_001.fastq.g                                                                                                                                                             z*
-rwxr-----+ 1 eak37 rnicholls  19M Oct 22 12:04 EK0239A11_S1_L001_R2_001.fastq.g                                                                                                                                                             z*
-rwxr-----+ 1 eak37 rnicholls  17M Oct 22 12:04 EK0239A11_S1_L001_R1_001.fastq.g                                                                                                                                                             z*
drwxr-S---+ 4 eak37 rnicholls    2 Oct 22 12:03 30-424840508/
drwxr-sr-x+ 6 eak37 rnicholls    6 Sep  1 15:51 results/
-rwxr-----+ 1 eak37 rnicholls 7.2M Sep  1 15:44 ref0-results.zip*
-rwxr-----+ 1 eak37 rnicholls  91K Sep  1 15:44 Genotyper_Results_Instructions.p                                                                                                                                                             df*
-rwxr-----+ 1 eak37 rnicholls 6.9M Sep  1 15:44 EK0239A2_R2_001.fastq.gz*
-rwxr-----+ 1 eak37 rnicholls 6.1M Sep  1 15:44 EK0239A2_R1_001.fastq.gz*
-rwxr-----+ 1 eak37 rnicholls 2.2M Sep  1 15:44 EK0239A1_R1_001.fastq.gz*
-rwxr-----+ 1 eak37 rnicholls 2.4M Sep  1 15:44 EK0239A1_R2_001.fastq.gz*
[eak37@login0b AmpliconSeq]$ cd 30-424840508
[eak37@login0b 30-424840508]$ ls -lthF
total 1.0K
drwxr-S---+ 2 eak37 rnicholls 7 Oct 22 12:03 00_fastq/
drwxr-S---+ 2 eak37 rnicholls 2 Oct 22 12:03 01_analysis/
[eak37@login0b 30-424840508]$ cd 00_fastq/
[eak37@login0b 00_fastq]$ ls -lthF
total 34M
-rwxr-----+ 1 eak37 rnicholls 3.0M Oct 22 12:03 EK0239A13_S3_L001_R2_001.fastq.gz*
-rwxr-----+ 1 eak37 rnicholls  408 Oct 22 12:03 md5sum_list.txt*
-rwxr-----+ 1 eak37 rnicholls  19M Oct 22 12:03 EK0239A12_S2_L001_R2_001.fastq.gz*
-rwxr-----+ 1 eak37 rnicholls 2.8M Oct 22 12:03 EK0239A13_S3_L001_R1_001.fastq.gz*
-rwxr-----+ 1 eak37 rnicholls  17M Oct 22 12:03 EK0239A12_S2_L001_R1_001.fastq.gz*
-rwxr-----+ 1 eak37 rnicholls  19M Oct 22 12:03 EK0239A11_S1_L001_R2_001.fastq.gz*
-rwxr-----+ 1 eak37 rnicholls  17M Oct 22 12:03 EK0239A11_S1_L001_R1_001.fastq.gz*

##not sure why but A13 files are smaller, probably less read depth
