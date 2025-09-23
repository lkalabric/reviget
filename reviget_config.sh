# --- Instala o repositório Conda e seus pacotes ---

# --- Configurações do ambiente e instalação dos pacotes requeridos ---
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

    # O comando 'conda create' cria o ambiente.
    # O '-y' (yes) aceita todas as confirmações automaticamente.
    # Adicionado o canal bioconda para encontrar os pacotes de bioinformática
    if conda create --name $ENV_NAME $PYTHON_VERSION $PACKAGES -c bioconda -c conda-forge -y; then
        echo "Sucesso: O ambiente '$ENV_NAME' foi criado com sucesso!"
    else
        echo "Erro: Falha ao criar o ambiente '$ENV_NAME'. Verifique as permissões ou a instalação do Conda."
        # Encerra o script com um código de erro
        exit 1
    fi
fi

# Atualização do Java
echo "Atualizando o Java no ambiente Conda reviget..."
conda activate reviget
conda update openjdk
java -version

# Change back to the parent directory before copying
cd 

# Copy the csv files from the cloned repository to the sample_data folder
echo "Copiando arquivos do repositório clonado para a pasta sample_data..."
cp repos/reviget/sample_data/* examples/reviget

