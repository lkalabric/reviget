#!/usr/bin/bash

# --- Pipeline setup sanity check ---
nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile test,conda_local,server \
         -r v2.2.0
      
exit 0;

# --- Análise dos dados de teste ---
nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile conda_local, server \
         -r v2.2.2 \
         -params-file examples/regivet/my_parameters_test.yml

nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile conda_local, server \
         -r v2.2.2 \
         -params-file examples/regivet/my_parameters_1.yml
