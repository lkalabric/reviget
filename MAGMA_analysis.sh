#!/usr/bin/bash

# --- Pipeline setup sanity check ---
# Na Fiocruz isso não roda por conta do acesso a internet tanto na rede corporativa quanto na rede wifi (independente da rede)
nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile test,docker,laptop \
         -r v2.2.0
      
exit 0;

# --- Análise dos dados de teste localmente ---
nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile docker,laptop \
         -r v2.2.2 \
         -params-file examples/reviget/my_parameters_1_local.yml

nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile docker,laptop \
         -r v2.2.2 \
         -params-file examples/reviget/my_parameters_3_local.yml

# --- Análise dos dados de teste remotamente ---
# Na Fiocruz isso não roda por conta do acesso a internet 
         nextflow run 'https://github.com/TORCH-Consortium/MAGMA' \
         -profile docker,laptop \
         -r v2.2.2 \
         -params-file examples/reviget/my_parameters_3_remote.yml
