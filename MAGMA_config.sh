#!/usr/bin/bash

# --- Pré-requisitos
# Java
java_config.sh

# Nextflow
nextflow_config.sh

# --- Running MAGMA using conda
# Download dos arquivos de configuração do MAGMA
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-env-1.yml
# Erro: O pacote gtak4 sugerido no recipe magma-env-1.yml não é compatível com Java 17 ou superior.
# A versão 4.2.6.1 é compatível apenas com Java 8 e o Nexflow necessita de Java 17 ou superior!
# Solução: Editar o recipe magma-env-1.yml substituindo gatk4=4.2.6.1 por gatk4=4.4.0.0 antes de prosseguir.
# Pausa a execução para edição do arquivo magma-env-1.yml
read -p "Pressione Enter para continuar quando esta correção for realizada..."
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-env-2.yml
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-tbprofiler-env.yml
wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/magma-ntmprofiler-env.yml


# Configurar criar cada ambiente individualmente
conda env create -n magma-env-1 --file magma-env-1.yml
conda env create -n magma-env-2 --file magma-env-2.yml
# Erro: Alguns arquivo tem extensão .yml são descritos como .yaml. Vamos manter tudo como .yml...
conda env create -n magma-tbprofiler-env --file magma-tbprofiler-env.yml
conda env create -n magma-ntmprofiler-env --file magma-ntmprofiler-env.yml

# Opcionalmente, podemos simplesmente baixar e configurar os ambientes utilizando o script a seguir
# Particularmente, não gostei dessa solução, pois os ambientes são criados em um local fora do padrão!
#wget https://raw.githubusercontent.com/TORCH-Consortium/MAGMA/master/conda_envs/setup_conda_envs.sh
#bash setup_conda_envs.sh

# Carregamento do WHO Resistance Catalog within tb-profiler
wget -O examples/reviget/resistance_db_who_v1.zip https://github.com/TORCH-Consortium/MAGMA/files/14559680/resistance_db_who_v1.zip
cd examples/reviget/
unzip resistance_db_who_v1.zip
