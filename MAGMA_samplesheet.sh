#!/usr/bin/bash

# --- Download de folhas de dados ---
wget -O examples/reviget/test.3samples.csv https://github.com/TORCH-Consortium/MAGMA/blob/master/samplesheet/test.3samples.csv
wget -O examples/reviget/MAGMA_samplesheet.csv https://github.com/TORCH-Consortium/MAGMA/blob/master/samplesheet/example_MAGMA_samplesheet.csv

# --- Download de dados ---
wget -O examples/reviget/SRR26331590_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR263/090/SRR26331590/SRR26331590_1.fastq.gz
wget -O examples/reviget/SRR26331590_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR263/090/SRR26331590/SRR26331590_2.fastq.gz
