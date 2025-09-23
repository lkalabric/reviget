#!/usr/bin/bash

# --- Download e instalação do pacote nextflow ---
wget -qO nextflow https://github.com/nextflow-io/nextflow/releases/download/v23.10.1/nextflow-23.10.1-all
chmod +x nextflow
mv nextflow bin/
nextflow info

# --- Atualização para a versão mais nova do pacote Nextflow ---
if nextflow self-update; then
    echo "Atualizando Nextflow para a versão mais recente..."
  else
   echo "Nextflow atualizado!"
fi
nextflow info
