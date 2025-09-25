#!/bin/bash
#
# Script para verificar a versão do Java e instalar o OpenJDK 21 se for inferior a 11.

echo "--- Iniciando verificação da versão do Java ---"

# 1. Verificar se o comando 'java' está disponível
if ! command -v java &> /dev/null
then
    echo "O Java não foi encontrado no sistema. Prosseguindo com a instalação do OpenJDK 21."
    MAJOR_VERSION=0
else
    # 2. Obter a string de versão completa (e.g., "1.8.0_302" ou "11.0.1")
    JAVA_FULL_VERSION=$(java -version 2>&1 | head -n 1 | awk -F '"' '/version/ {print $2}')

    # 3. Extrair a versão principal (Major Version)
    # Trata versões antigas (1.x, onde x é a versão principal) e novas (11, 17, 21)
    if [[ $JAVA_FULL_VERSION == 1.* ]]; then
        # Ex: de "1.8.0_302" extrai "8"
        MAJOR_VERSION=$(echo "$JAVA_FULL_VERSION" | cut -d'.' -f2)
    else
        # Ex: de "11.0.1" extrai "11"
        MAJOR_VERSION=$(echo "$JAVA_FULL_VERSION" | cut -d'.' -f1)
    fi

    echo "Versão do Java detectada: $MAJOR_VERSION (Completa: $JAVA_FULL_VERSION)"
fi

# 4. Comparar a versão detectada com a versão 11
if (( MAJOR_VERSION < 11 )); then
    echo "A versão do Java ($MAJOR_VERSION) é inferior a 11. Iniciando a instalação do OpenJDK 21..."
    
    # --- Se for um sistema baseado em Debian/Ubuntu (APT) ---
    # É necessário privilégios de root para instalar pacotes.
    if command -v apt &> /dev/null; then
        echo "Usando APT (Debian/Ubuntu)..."
        sudo apt update
        sudo apt install openjdk-21-jdk -y
        if [ $? -eq 0 ]; then
            echo "OpenJDK 21 instalado com sucesso."
        else
            echo "ERRO: Falha ao instalar o OpenJDK 21 via APT. Verifique as permissões ou se o pacote está disponível."
        fi
    
    # --- Se for um sistema baseado em RHEL/CentOS/Fedora (YUM/DNF) ---
    elif command -v dnf &> /dev/null; then
        echo "Usando DNF (Fedora/RHEL 8+)..."
        sudo dnf install java-21-openjdk -y
        if [ $? -eq 0 ]; then
            echo "Java 21 instalado com sucesso."
        else
            echo "ERRO: Falha ao instalar o Java 21 via DNF. Verifique as permissões ou o nome do pacote."
        fi
    
    elif command -v yum &> /dev/null; then
        echo "Usando YUM (RHEL/CentOS 7-)..."
        sudo yum install java-21-openjdk -y
        if [ $? -eq 0 ]; then
            echo "Java 21 instalado com sucesso."
        else
            echo "ERRO: Falha ao instalar o Java 21 via YUM. Verifique as permissões ou o nome do pacote."
        fi

    else
        echo "ATENÇÃO: Não foi possível identificar um gerenciador de pacotes compatível (apt, dnf, yum). Instale o Java manualmente."
    fi

    # 5. Configurar a versão recém-instalada como padrão (se o comando estiver disponível)
    if command -v update-alternatives &> /dev/null; then
        echo "Configurando o Java 21 como padrão usando update-alternatives..."
        sudo update-alternatives --config java
    fi
    
else
    echo "A versão do Java ($MAJOR_VERSION) é 11 ou superior. Nenhuma ação necessária."
fi

echo "--- Verificação concluída ---"
echo "Para verificar a nova versão, use: java -version"
