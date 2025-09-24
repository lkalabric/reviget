#!/usr/bin/bash

# --- Running MAGMA using conda

# Download dos arquivos de configuração do MAGMA
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-env-1.yml
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-env-2.yml
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-tbprofiler-env.yml
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-ntmprofiler-env.yml

# Criação de cada ambiente individualmente
conda env create -n magma-env-1 --file magma-env-1.yml
conda env create -n magma-env-2 --file magma-env-2.yml
conda env create -n magma-tbprofiler-env --file magma-tbprofiler-env.yml
conda env create -n magma-ntmprofiler-env --file magma-ntmprofiler-env.yml

# Opcionalmente, podemos simplesmente baixar e configurar os ambientes utilizando o script a seguir
#wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/setup_conda_envs.sh
#bash setup_conda_envs.sh

# Carregamento do WHO Resistance Catalog within tb-profiler
wget -O examples/reviget/resistance_db_who_v1.zip https://github.com/TORCH-Consortium/MAGMA/files/14559680/resistance_db_who_v1.zip
cd examples/reviget/
unzip resistance_db_who_v1.zip
