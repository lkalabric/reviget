#!/usr/bin/bash

# -- Download dos arquivos de configuração do MAGMA
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-env-1.yml
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-env-2.yml
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-tbprofiler-env.yml
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-ntmprofiler-env.yml

# Configurar criar cada ambiente individualmente
conda env create -n magma-env-1 --file magma-env-1.yml
conda env create -n magma-env-2 --file magma-env-2.yml
conda env create -n magma-tbprofiler-env --file magma-tbprofiler-env.yml
conda env create -n magma-ntmprofiler-env --file magma-ntmprofiler-env.yml

# Opcionalmente, podemos simplesmente baixar e configurar os ambientes utilizando o script a seguir
#wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/setup_conda_envs.sh
#bash setup_conda_envs.sh
