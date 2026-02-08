#!/bin/bash

# $1 = Caminho do projeto
# Padrão: Todo dia às 08:30

PROJETO_DIR=$1
SCRIPT_PATH="$(pwd)/scripts/aczg_daily_commit.sh"

if [ -z "$PROJETO_DIR" ]; then
    echo "Uso: aczg_schedule_commit <caminho_projeto>"
    exit 1
fi

# 30 08 * * * = 08:30 todos os dias
CRON_JOB="30 08 * * * $SCRIPT_PATH $PROJETO_DIR"

(crontab -l 2>/dev/null | grep -v "$SCRIPT_PATH"; echo "$CRON_JOB") | crontab -

echo "Commit diário agendado para 08:30 no projeto $PROJETO_DIR"
