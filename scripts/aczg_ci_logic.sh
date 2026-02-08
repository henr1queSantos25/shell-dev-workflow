#!/bin/bash

# Configurações
LOG_FILE="$HOME/aczg_ci.log"
PROJETO_DIR=$1
NOME_PROJETO=$(basename "$PROJETO_DIR")

export DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/$(id -u)/bus}"
export DISPLAY=:0

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

if [ ! -d "$PROJETO_DIR" ]; then
    log "ERRO: Diretório $PROJETO_DIR não encontrado."
    exit 1
fi

cd "$PROJETO_DIR" || exit

log "Iniciando CI do projeto $NOME_PROJETO..."

# O script procura por um arquivo padrão de build dentro do projeto.
SCRIPT_BUILD="./build.sh"

if [ -f "$SCRIPT_BUILD" ]; then
    # Dá permissão de execução caso não tenha
    chmod +x "$SCRIPT_BUILD"
    
    ./"$SCRIPT_BUILD" >> "$LOG_FILE" 2>&1
    
    # Captura o status de saída (0 = sucesso, diferente de 0 = erro)
    STATUS=$?
else
    log "ERRO CRÍTICO: Arquivo '$SCRIPT_BUILD' não encontrado no projeto."
    STATUS=127 # Código de erro para "comando não encontrado"
fi

if [ $STATUS -eq 0 ]; then
    log "SUCESSO: Build do projeto $NOME_PROJETO passou."
else
    log "FALHA: Erro ao executar build do projeto $NOME_PROJETO."
    notify-send "Build Falhou" " Erro no projeto $NOME_PROJETO. Verifique os logs." -u critical
fi
