#!/usr/bin/bash

# --- Análise dos dados de teste ---
#source /root/miniconda3/bin/activate magma-env-1
nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile conda_local, server \
         -r v2.2.2 \
         -params-file /content/sample_data/my_parameters_test.yml

exit 0;

nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile conda_local,server \
         -r v2.2.0

nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile conda_local, server \
         -r v2.2.2 \
         -params-file sample_data/my_parameters_1.yml
