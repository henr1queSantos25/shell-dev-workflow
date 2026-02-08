#!/bin/bash

# $1 = Caminho onde a pasta será criada (ex: /home/henrique/projetos)
# $2 = Nome do projeto (ex: novo-site)

CAMINHO=$1
NOME_PROJETO=$2
CAMINHO_COMPLETO="$CAMINHO/$NOME_PROJETO"

# 1. Cria a pasta
mkdir -p "$CAMINHO_COMPLETO"

# 2. Entra na pasta
cd "$CAMINHO_COMPLETO" || exit

# 3. Cria o arquivo README.md com o texto solicitado
echo "projeto $NOME_PROJETO inicializado...." > README.md

# 4. Inicia o repositório Git
git init

# 5. Adiciona o README ao stage
git add README.md

# 6. Faz o commit com a mensagem solicitada
git commit -m "first commit - repositório configurado"

echo "Projeto $NOME_PROJETO criado em $CAMINHO_COMPLETO"
