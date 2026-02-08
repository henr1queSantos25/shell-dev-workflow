#!/bin/bash

echo "Iniciando configuração do ambiente ACZG-Hero..."

# 1. Definir onde os scripts serão instalados
INSTALL_DIR="$HOME/.aczg-hero"
BIN_DIR="$INSTALL_DIR/bin"

# 2. Criar a estrutura de pastas
if [ ! -d "$BIN_DIR" ]; then
    echo "Criando diretório de instalação em $BIN_DIR..."
    mkdir -p "$BIN_DIR"
fi

# 3. Copiar os scripts e dar permissão
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_SOURCE="$CURRENT_DIR/scripts"

if [ -d "$SCRIPTS_SOURCE" ]; then
    echo "Copiando scripts para o local padrão..."
    cp "$SCRIPTS_SOURCE/"*.sh "$BIN_DIR/"
    chmod +x "$BIN_DIR/"*.sh
    echo "Scripts instalados e permissões configuradas."
else
    echo "ERRO: Pasta 'scripts' não encontrada em $CURRENT_DIR."
    exit 1
fi

# 4. Configurar o Shell
# Detecta qual shell está rodando de verdade
USER_SHELL=$(basename "$SHELL")

if [ "$USER_SHELL" = "zsh" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ "$USER_SHELL" = "bash" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    # Fallback: tenta adivinhar se a detecção falhou
    if [ -f "$HOME/.bashrc" ]; then
        SHELL_RC="$HOME/.bashrc"
    elif [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
    else
        SHELL_RC="$HOME/.bashrc"
        touch "$SHELL_RC"
    fi
fi

echo "Configurando arquivo de shell detectado: $SHELL_RC (Shell atual: $USER_SHELL)"

# Verifica se já instalamos antes para não duplicar linhas
if grep -q "# ACZG-HERO CONFIG START" "$SHELL_RC"; then
    echo "A configuração já existe no $SHELL_RC. Pulando etapa de escrita."
else
    # Escreve as configurações no final do arquivo
    cat <<EOT >> "$SHELL_RC"

# --- ACZG-HERO CONFIG START ---
# Adiciona os scripts ao PATH para serem executáveis diretamente
export PATH="\$PATH:$BIN_DIR"

# Task 1: Alias para criar projetos
alias aczgcreate='aczg_create.sh'

# Task 2: Aliases de fluxo de feature
alias aczginit='aczg_init.sh'
alias aczgfinish='aczg_finish.sh'

# Task 4: Alias para ver logs (Rastreia o arquivo definido na Task 3)
alias aczglog='tail -n 50 -f ~/aczg_ci.log'

# --- ACZG-HERO CONFIG END ---
EOT
    echo "Aliases e PATH gravados com sucesso em $SHELL_RC."
fi

echo ""
echo "Instalação Concluída!"
echo "IMPORTANTE: Para usar os comandos agora, execute:"
echo "    source $SHELL_RC"