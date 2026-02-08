#!/bin/bash

NOME_ENTREGA=$1

if [ -z "$NOME_ENTREGA" ]; then
    echo " Erro: Por favor, forneça o nome da entrega que você quer finalizar."
    echo "Uso: aczgfinish <nome-da-entrega>"
    exit 1
fi

BRANCH_NAME="feat-$NOME_ENTREGA"

# Volta para a main
git checkout main

# Faz o merge da feature
echo "--- Realizando Merge de $BRANCH_NAME com a main ---"
git merge "$BRANCH_NAME"

# Deleta a branch local
echo "--- Deletando branch local $BRANCH_NAME ---"
git branch -d "$BRANCH_NAME"

# Tenta deletar a branch remota (caso exista)
echo "--- Tentando deletar branch remota (se existir) ---"
git push origin --delete "$BRANCH_NAME" 2>/dev/null || echo "Remote não encontrado ou branch não existe remotamente (ignorando)."

echo "Feature $NOME_ENTREGA finalizada com sucesso!"
