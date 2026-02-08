#!/bin/bash

# $1 (ex: login-page)

NOME_ENTREGA=$1

if [ -z "$NOME_ENTREGA" ]; then
    echo " Erro: Por favor, forneça um nome para a entrega."
    echo "Uso: aczginit <nome-da-entrega>"
    exit 1
fi

echo "--- Status do Repositório ---"
git status

# Cria a branch e já faz o checkout (-b)
git checkout -b "feat-$NOME_ENTREGA"

echo -e "\n--- Branches (Locais e Remotas) ---"
git branch -a
