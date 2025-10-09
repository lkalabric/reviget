#!/usr/bin/bah

# ----------------------------------------------------------------------
# Script para instalar o Miniconda3 no Linux, SE ele ainda não estiver instalado.
# ----------------------------------------------------------------------

# Define o nome do instalador
INSTALLER_FILE="Miniconda3-latest-Linux-x86_64.sh"
# Define o URL para download
CONDA_URL="https://repo.anaconda.com/miniconda/$INSTALLER_FILE"
# Define o diretório de instalação padrão
INSTALL_DIR="$HOME/miniconda3"

echo "Verificando a instalação do Conda..."

# Verifica se o comando 'conda' existe no PATH
if command -v conda &> /dev/null
then
    echo "Conda já está instalado e acessível. Pulando a instalação."
    echo "Localização: $(command -v conda)"
else
    echo "Conda não encontrado. Iniciando a instalação do Miniconda3..."
    
    # 1. Baixar o instalador
    echo "Baixando o instalador do Miniconda3..."
    # Usa curl para baixar o arquivo. -O salva com o nome original.
    curl -O $CONDA_URL

    # Verifica se o download foi bem-sucedido
    if [ ! -f "$INSTALLER_FILE" ]; then
        echo "ERRO: Falha ao baixar o instalador em $CONDA_URL"
        exit 1
    fi
    
    # 2. Executar a instalação em modo silencioso
    echo "Iniciando a instalação em $INSTALL_DIR..."
    # -b: modo batch (não pede interação)
    # -p: define o prefixo (diretório) de instalação
    # -u: atualiza a instalação existente, se houver
    bash $INSTALLER_FILE -b -p "$INSTALL_DIR" -u

    # 3. Limpar o instalador
    echo "Removendo o arquivo do instalador..."
    rm $INSTALLER_FILE

    # 4. Inicializar o Conda para o shell
    echo "Inicializando o Conda (executando conda init)..."
    
    # Adiciona o diretório bin do Conda ao PATH temporariamente para poder rodar 'conda'
    export PATH="$INSTALL_DIR/bin:$PATH"
    
    # Executa a inicialização do shell. Isso modifica o arquivo ~/.bashrc
    conda init

    if [ $? -eq 0 ]; then
        echo "--------------------------------------------------------"
        echo "INSTALAÇÃO CONCLUÍDA COM SUCESSO!"
        echo "Para usar o comando 'conda' imediatamente, você deve:"
        echo "1. Abrir um novo terminal OU"
        echo "2. Executar 'source ~/.bashrc' neste terminal."
        echo "--------------------------------------------------------"
    else
        echo "ERRO: O comando 'conda init' falhou."
        exit 1
    fi
fi

# --- Configurações do ambiente Conda e instalação dos pacotes requeridos ---
# Defina o nome do ambiente Conda que você quer verificar/criar
# Exemplo: ENV_NAME="reviget"
ENV_NAME="reviget"

# Defina as bibliotecas que você quer instalar, se o ambiente for criado
# Exemplo: PYTHON_VERSION="python=3.9"
PYTHON_VERSION="python=3.8.8"

# Exemplo: PACKAGES="fastqc trimmomatic spades velvet"
PACKAGES="fastqc trimmomatic cutadapt spades velvet iqtree itol-config bwa"

# --- Lógica do Script ---
echo "Verificando a existência do ambiente Conda: '$ENV_NAME'..."

# O comando 'conda info --envs' lista todos os ambientes.
# O 'grep -q' busca o nome do ambiente e retorna 0 se encontrar, 1 se não.
# A opção '-q' (quiet) suprime a saída do grep.
if conda info --envs | grep -q "$ENV_NAME"; then
    echo "Sucesso: O ambiente '$ENV_NAME' já existe."
else
    echo "Ambiente Conda '$ENV_NAME' não encontrado. Criando..."

    # To accept these channels' Terms of Service, run the following commands
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

    # O comando 'conda create' cria o ambiente.
    # O '-y' (yes) aceita todas as confirmações automaticamente.
    # Adicionado o canal bioconda para encontrar os pacotes de bioinformática
    if conda create --name "$ENV_NAME" $PYTHON_VERSION $PACKAGES -c bioconda -c conda-forge -y; then
        echo "Sucesso: O ambiente '$ENV_NAME' foi criado com sucesso!"
    else
        echo "Erro: Falha ao criar o ambiente '$ENV_NAME'. Verifique as permissões ou a instalação do Conda."
        # Encerra o script com um código de erro
        exit 1
    fi
fi
