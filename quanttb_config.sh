# Link: https://github.com/AbeelLab/quanttb/

# Pré-requsitos
# sudo apt install python
# sudo apt install python-setuptools
# sudo apt install python-dev
# sudo apt install samtools
# sudo apt install bwa

# Conda
# --- Instala o repositório Conda e seus pacotes ---

# --- Configurações do ambiente e instalação dos pacotes requeridos ---
# Defina o nome do ambiente Conda que você quer verificar/criar
# Exemplo: ENV_NAME="reviget"
ENV_NAME="quanttb"

# Defina as bibliotecas que você quer instalar, se o ambiente for criado
# Exemplo: PYTHON_VERSION="python=3.9"
PYTHON_VERSION="python=2.2.0"

# Exemplo: PACKAGES="fastqc trimmomatic spades velvet"
PACKAGES="bwa samtools quanttb"

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
conda activate $ENV_NAME
conda update openjdk
java -version

# Instalação do QuantTb
# wget -O quanttb-1.01.tar.gz https://github.com/AbeelLab/quanttb/archive/refs/tags/1.01.tar.gz
# tar -zxvf quanttb-1.01.tar.gz
# cd quanttb-1.01
# sudo python setup.py install


