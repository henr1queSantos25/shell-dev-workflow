# ZG Hero Project

> **Shell Dev Workflow** - Conjunto profissional de ferramentas de automação em Shell Script para padronizar e agilizar o fluxo de trabalho de desenvolvimento em ambientes Linux.

---

## Tabela de Conteúdos

- [Visão Geral](#visão-geral)
- [Funcionalidades Principais](#funcionalidades-principais)
- [Requisitos](#requisitos)
- [Instalação](#instalação)
- [Guia de Uso](#guia-de-uso)
  - [Gerenciamento de Projetos](#1-gerenciamento-de-projetos)
  - [Fluxo de Trabalho Git](#2-fluxo-de-trabalho-git-feature-branch)
  - [Monitoramento e CI](#3-monitoramento-e-ci-integração-contínua)
  - [Backup Automático](#4-backup-automático)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Desinstalação](#desinstalação)
- [Contribuindo](#contribuindo)
- [Licença](#licença)

---

## Visão Geral

O **Shell Dev Workflow** oferece soluções completas para:
- **Scaffolding de projetos** com estrutura padronizada
- **Gerenciamento simplificado de branches** (Git Flow)
- **Monitoramento contínuo local** (CI) com notificações
- **Rotinas de backup automático** para proteção de código

O objetivo principal é eliminar tarefas repetitivas e configurar um ambiente de desenvolvimento robusto com um único comando. Todas as ferramentas são instaladas no `PATH` do usuário, permitindo execução global em qualquer diretório do sistema.

---

## Funcionalidades Principais

| Funcionalidade | Descrição |
|----------------|-----------|
| **Inicialização de Projetos** | Cria estrutura de diretórios, inicializa repositório Git e gera documentação padrão |
| **Git Flow Automatizado** | Scripts para criação e finalização de feature branches, incluindo merge e limpeza automática |
| **Integração Contínua Local** | Sistema de monitoramento que executa scripts de build periodicamente e notifica sobre falhas |
| **Backup Diário** | Agendamento automático de commits para garantir a segurança do código ao final do dia |
| **Logs e Monitoramento** | Comandos dedicados para visualização de logs de operação em tempo real |

---

## Requisitos

Antes de instalar, certifique-se de ter:

- **Sistema Operacional:** Linux (Testado em Ubuntu/Debian)
- **Git:** Instalado e configurado
- **Shell:** Bash ou Zsh
- **notify-send:** Para notificações de desktop (geralmente pré-instalado em distros com interface gráfica)

---

## Instalação

O projeto conta com um script de configuração automática que detecta o shell do usuário (Bash ou Zsh), move os scripts para um diretório oculto na home (`~/.aczg-hero`) e configura o PATH e Aliases.

### Passo 1: Clone o Repositório

```bash
git clone <URL_DO_SEU_REPOSITORIO>
cd ZG-Hero-Project
```

### Passo 2: Execute o Script de Configuração

```bash
chmod +x configurarAmbiente.sh
./configurarAmbiente.sh
```

### Passo 3: Recarregue as Configurações do Terminal

```bash
source ~/.bashrc
# Ou, se estiver usando Zsh:
source ~/.zshrc
```

**Instalação concluída!** Os comandos agora estão disponíveis globalmente.

---

## Guia de Uso

Após a instalação, os seguintes comandos estarão disponíveis globalmente no seu terminal.

### 1. Gerenciamento de Projetos

#### `aczgcreate <caminho> <nome_do_projeto>`

Cria uma nova pasta no caminho especificado, inicializa o Git, cria um `README.md` e realiza o primeiro commit.

**Exemplo:**

```bash
aczgcreate ~/projetos meu-novo-site
```

**Resultado:**
- Diretório `~/projetos/meu-novo-site` criado
- Repositório Git inicializado
- README.md gerado automaticamente
- Commit inicial realizado

---

### 2. Fluxo de Trabalho Git (Feature Branch)

#### `aczginit <nome_da_feature>`

Mostra o status atual, cria uma branch `feat-<nome>` e altera o contexto para ela.

**Exemplo:**

```bash
aczginit tela-login
```

**Resultado:**
- Branch `feat-tela-login` criada
- Checkout automático para a nova branch
- Status do repositório exibido

#### `aczgfinish <nome_da_feature>`

Retorna para a branch `master`, realiza o merge da feature, deleta a branch local e tenta deletar a remota.

**Exemplo:**

```bash
aczgfinish tela-login
```

**Resultado:**
- Merge de `feat-tela-login` para `master`
- Branch local `feat-tela-login` removida
- Tentativa de remoção da branch remota (se existir)

---

### 3. Monitoramento e CI (Integração Contínua)

O sistema de CI local funciona agendando tarefas via **Cron**. Para que o monitoramento funcione, o projeto alvo deve conter um script executável chamado `build.sh` na raiz.

#### `aczg_ci_schedule.sh <caminho_do_projeto> <intervalo_minutos>`

Configura uma tarefa no Cron para rodar o script de build periodicamente. Se o build falhar (exit code diferente de 0), uma notificação visual será exibida no desktop.

**Exemplo:**

```bash
aczg_ci_schedule.sh ~/projetos/meu-novo-site 5
```

**Resultado:**
- Build executado a cada 5 minutos
- Notificação desktop em caso de falha
- Logs armazenados automaticamente

#### `aczglog`

Exibe os logs de execução do CI em tempo real (`tail -f`).

**Exemplo:**

```bash
aczglog
```

---

### 4. Backup Automático

#### `aczg_schedule_commit.sh <caminho_do_projeto>`

Configura uma tarefa diária (executada às **08:30**) que verifica alterações pendentes no projeto e realiza um commit automático com a data atual.

**Exemplo:**

```bash
aczg_schedule_commit.sh ~/projetos/meu-novo-site
```

**Resultado:**
- Commit automático diário às 23:55
- Mensagem de commit padronizada com a data
- Apenas se houver alterações pendentes

---

## Estrutura do Projeto

```
ZG-Hero-Project/
├── configurarAmbiente.sh          # Script instalador (entrypoint)
├── README.md                       # Documentação do projeto
└── scripts/                        # Lógica de automação
    ├── aczg_create.sh             # Criação de projetos
    ├── aczg_init.sh               # Inicialização de features (Git Flow)
    ├── aczg_finish.sh             # Finalização de features (Git Flow)
    ├── aczg_ci_logic.sh           # Execução de testes e notificações
    ├── aczg_ci_schedule.sh        # Configuração do Cron para CI
    ├── aczg_daily_commit.sh       # Lógica de backup diário
    └── aczg_schedule_commit.sh    # Configuração do Cron para backup
```

---

## Desinstalação

Para remover completamente o **ZG Hero Project** do seu sistema:

1. **Remova o diretório de instalação:**
   ```bash
   rm -rf ~/.aczg-hero
   ```

2. **Edite seu arquivo de configuração do shell** (`.bashrc` ou `.zshrc`) e remova as linhas adicionadas pelo script de instalação ao final do arquivo.

3. **Recarregue o terminal:**
   ```bash
   source ~/.bashrc  # ou source ~/.zshrc
   ```

---
