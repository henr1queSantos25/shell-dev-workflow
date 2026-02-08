#!/bin/bash

# $1 = Caminho do projeto

PROJETO_DIR=$1
LOG_FILE="$HOME/aczg_daily_commit.log"

if [ ! -d "$PROJETO_DIR" ]; then
    echo "$(date) - Erro: Dir $PROJETO_DIR não existe" >> "$LOG_FILE"
    exit 1
fi

cd "$PROJETO_DIR" || exit

# Verifica se há mudanças para commitar
if [[ -z $(git status -s) ]]; then
    echo "$(date) - Nada a commitar em $(basename "$PROJETO_DIR")" >> "$LOG_FILE"
    exit 0
fi

git add .
git commit -m "backup diario: $(date '+%Y-%m-%d')"

if [ $? -eq 0 ]; then
    echo "$(date) - Commit diário realizado com sucesso em $(basename "$PROJETO_DIR")" >> "$LOG_FILE"
    # Tenta push se tiver remote configurado
    git push origin master 2>/dev/null
else
    echo "$(date) - Falha ao realizar commit em $(basename "$PROJETO_DIR")" >> "$LOG_FILE"
fi
