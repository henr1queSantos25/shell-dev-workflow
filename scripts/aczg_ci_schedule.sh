#!/bin/bash

# $1 = Caminho do projeto
# $2 = Periodicidade em minutos (Default: 5)

PROJETO_DIR=$1
MINUTOS=${2:-5} 

if [ -z "$PROJETO_DIR" ]; then
    echo "Uso: aczg_ci_schedule <caminho_projeto> [minutos]"
    exit 1
fi

SCRIPT_PATH="$(pwd)/scripts/aczg_ci_logic.sh"

# Verifica se o script de lógica existe
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Erro: Script de lógica não encontrado em $SCRIPT_PATH"
    exit 1
fi

# Cria a linha do cron
# Exemplo: */5 * * * * /home/user/.../scripts/aczg_ci_logic.sh /home/user/projeto
CRON_JOB="*/$MINUTOS * * * * $SCRIPT_PATH $PROJETO_DIR"

# crontab
(crontab -l 2>/dev/null | grep -v "$SCRIPT_PATH"; echo "$CRON_JOB") | crontab -

echo "Cron Job agendado para rodar a cada $MINUTOS minutos monitorando $PROJETO_DIR"
