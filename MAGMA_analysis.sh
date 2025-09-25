#!/usr/bin/bash

# --- Pipeline setup sanity check ---
nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile test \
         -r v2.2.2
      
exit 0;

# --- Análise dos dados de teste ---
nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile conda_local, server \
         -r v2.2.2 \
         -params-file examples/reviget/my_parameters_test.1sample.yml

nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile conda_local, server \
         -r v2.2.2 \
         -params-file examples/regivet/my_parameters_1.yml
