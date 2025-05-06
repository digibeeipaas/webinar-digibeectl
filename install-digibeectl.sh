#!/bin/bash

# Este script instala e configura o DigibeeCTL, uma ferramenta CLI para integração com a plataforma Digibee.
# Ele pode ser usado localmente ou em um ambiente de CI/CD, como o GitHub Actions.

# ============================
# Configuração de Variáveis
# ============================
# As variáveis abaixo podem ser configuradas manualmente ou obtidas do ambiente do GitHub Actions.

# Caminho onde o DigibeeCTL será instalado
# DIGIBEECTL_PATH="/usr/local/bin"

# Chave de autenticação para o DigibeeCTL
# DIGIBEECTL_AUTH_KEY="ADICIONAR DIGIBEECTL_AUTH_KEY"

# Chave secreta para o DigibeeCTL
# DIGIBEECTL_SECRET_KEY="ADICIONAR DIGIBEECTL_SECRET_KEY"

# Token JSON necessário para autenticação
# DIGIBEECTL_TOKEN_JSON="ADICIONAR DIGIBEECTL_TOKEN_JSON"

# Para uso no GitHub Actions, as variáveis podem ser definidas como segredos:
# DIGIBEECTL_PATH="${{ secrets.DIGIBEECTL_PATH }}"
# DIGIBEECTL_AUTH_KEY="${{ secrets.DIGIBEECTL_AUTH_KEY }}"
# DIGIBEECTL_SECRET_KEY="${{ secrets.DIGIBEECTL_SECRET_KEY }}"
# DIGIBEECTL_TOKEN_JSON="${{ secrets.DIGIBEECTL_TOKEN_JSON }}"

# ============================
# Atualização do Sistema
# ============================
# Atualiza os pacotes do sistema e instala dependências necessárias (curl e jq).
sudo apt update && sudo apt install -y curl jq

# ============================
# Instalação do DigibeeCTL
# ============================
# Baixa e executa o script de instalação do DigibeeCTL.
echo "Baixando e configurando DigibeeCTL..."
curl -s https://storage.googleapis.com/digibee-release-test/releases/install.sh | bash

# ============================
# Configuração do Caminho
# ============================
# Cria o diretório para o DigibeeCTL e adiciona o caminho ao arquivo de configuração do shell.
mkdir -p "${DIGIBEECTL_PATH}"
echo "export DIGIBEECTL_PATH=${DIGIBEECTL_PATH}" >> ~/.bashrc
source ~/.bashrc
echo "DigibeeCTL configurado com sucesso."

# ============================
# Criação do Arquivo de Token
# ============================
# Cria um arquivo JSON contendo o token necessário para autenticação.
echo "Criando arquivo de token..."
echo '{"data":"'"${DIGIBEECTL_TOKEN_JSON}"'","configVersion":"1.0"}' > token.json
echo "Arquivo de token criado. Conteúdo:"
cat token.json

# ============================
# Configuração de Credenciais
# ============================
# Configura as credenciais do DigibeeCTL usando o arquivo de token, chave secreta e chave de autenticação.
echo "Configurando credenciais do DigibeeCTL..."
digibeectl config set --file "token.json" --secret-key "${DIGIBEECTL_SECRET_KEY}" --auth-key "${DIGIBEECTL_AUTH_KEY}"
echo "Credenciais configuradas com sucesso."

# ============================
# Remoção do Arquivo de Token
# ============================
# Por segurança, o arquivo de token é removido após a configuração.
# echo "Removendo arquivo de token por segurança..."
# rm -f token.json