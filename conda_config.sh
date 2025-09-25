#!/usr/bin/bah

# --- Instalação do gerenciador Conda no Linux ---
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

ln -s /home/kalabric/miniconda3/bin/conda /usr/bin/conda
conda --version
