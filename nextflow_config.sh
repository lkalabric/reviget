#!/usr/bin/bash

# --- Atualização do Linux ---
sudo apt update
sudo apt upgrade

# --- Pré-requesitos Java 17 ou superior
java_config.sh

# Define o nome do instalador
INSTALLER_FILE="nextflow-23.10.1-all"
# Define o URL para download
NEXTFLOW_URL="https://github.com/nextflow-io/nextflow/releases/download/v23.10.1/$INSTALLER_FILE"
# Define o diretório de instalação padrão
DOWNLOAD_DIR="$HOME/Downloads"
INSTALL_DIR="$HOME/bin"

# Verifica se o comando 'nextflow' existe no PATH
echo "Verificando a instalação do Nextflow..."

# --- Download e instalação do pacote nextflow ---
if [ command -v nextflow &> /dev/null ]; then
    echo "Nextflow já está instalado e acessível. Atualizando Nextflow para a versão mais recente..."
    echo "Localização: $(command -v nextflow)"
    # --- Atualização para a versão mais nova do pacote Nextflow ---
    if nextflow self-update; then
        echo "Atualizando Nextflow para a versão mais recente..."
      else
       echo "Nextflow atualizado!"
    fi
    exit 1
else
    echo "Nextflow não encontrado. Iniciando a instalação do Nextflow..."
    wget -qO "$DOWNLOAD_DIR/$INSTALLER_FILE" $NEXTFLOW_URL
    
    # 1. Verifica se o download foi bem-sucedido
    if [ ! -f "$DOWNLOAD_DIR/$INSTALLER_FILE" ]; then
        echo "ERRO: Falha ao baixar o instalador em $NEXTFLOW_URL"
        exit 1
    fi

    # 2. Executar a instalação em modo silencioso
    echo "Iniciando a instalação em $INSTALL_DIR..."
    cp "$DOWNLOAD_DIR/$INSTALLER_FILE" $INSTALL_DIR/nextflow
    chmod +x $INSTALL_DIR/nextflow
        
    # 3. Adiciona o diretório bin do Conda ao PATH temporariamente para poder rodar 'conda'
    export PATH="$INSTALL_DIR:$PATH"
    # Executa a inicialização do shell. Isso modifica o arquivo ~/.bashrc
    source ~/.bashrc
    
    # 4. Executa a inicialização do shell. Isso modifica o arquivo ~/.bashrc
    nextflow info

    if [ $? -eq 0 ]; then
        echo "Instalação concluída com sucesso!"
    else
        echo "ERRO: O comando 'nextflow info' falhou."
        exit 1
    fi

    # --- Atualização para a versão mais nova do pacote Nextflow ---
    if nextflow self-update; then
        echo "Atualizando Nextflow para a versão mais recente..."
        nextflow info
      else
       echo "Nextflow atualizado!"
    fi
fi
