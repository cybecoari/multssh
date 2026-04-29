#!/bin/bash

# ============================================================
# Script de Menu CYBERCOARI
# API: https://cybercoari.app.br/api/validar.php?key=CHAVE
# ============================================================

# Criando comando mko (opcional)
echo "/root/install.sh" > /bin/mko && chmod +x /bin/mko > /dev/null 2>&1

# ============================================================
# Função para validar chave via API (compatível com espaços)
# ============================================================
validar_chave() {
    local chave=$1
    local resposta=$(curl -s "https://cybercoari.app.br/api/validar.php?key=${chave}")
    
    if echo "$resposta" | grep -qE '"valida"[[:space:]]*:[[:space:]]*true'; then
        return 0
    else
        return 1
    fi
}

# ============================================================
# Função para solicitar e verificar a chave
# ============================================================
obter_e_validar_chave() {
    if [[ -n "$CHAVE_VALIDADA" ]]; then
        return 0
    fi

    if [[ -f /root/key.txt ]]; then
        CHAVE=$(cat /root/key.txt)
        if validar_chave "$CHAVE"; then
            CHAVE_VALIDADA="$CHAVE"
            echo -e "\033[1;32mChave validada! Acesso liberado.\033[0m"
            sleep 1
            return 0
        else
            echo -e "\033[1;31mChave em /root/key.txt é inválida.\033[0m"
            rm -f /root/key.txt
        fi
    fi

    echo -e "\033[1;33m╔════════════════════════════════════════════════════╗\033[0m"
    echo -e "\033[1;33m║         DIGITE SUA CHAVE DE AUTORIZAÇÃO           ║\033[0m"
    echo -e "\033[1;33m╚════════════════════════════════════════════════════╝\033[0m"
    echo -ne "\033[1;32mCHAVE: \033[0m"
    read -s CHAVE
    echo
    if validar_chave "$CHAVE"; then
        echo "$CHAVE" > /root/key.txt
        CHAVE_VALIDADA="$CHAVE"
        echo -e "\033[1;32m✓ Chave válida! Acesso liberado.\033[0m"
        sleep 1
        return 0
    else
        echo -e "\033[1;31m✗ Chave inválida! Acesso negado.\033[0m"
        sleep 2
        return 1
    fi
}

# ============================================================
# Funções de instalação (substitua pelos seus scripts)
# ============================================================
SSHPRO () { echo -e "\033[1;36mInstalando SSH PRO...\033[0m"; sleep 2; }
SSHPLUS () { echo -e "\033[1;36mInstalando SSH PLUS...\033[0m"; sleep 2; }
SSHPREMIUM () { echo -e "\033[1;36mInstalando SSH PREMIUM...\033[0m"; sleep 2; }
PWEBPRO () { echo -e "\033[1;36mInstalando PAINEL WEB PRO...\033[0m"; sleep 2; }
PWEBPLUS () { echo -e "\033[1;36mInstalando PAINEL WEB PLUS...\033[0m"; sleep 2; }
HABILITARROOT () { echo -e "\033[1;36mHabilitando root...\033[0m"; sleep 2; }
ATTSSL () { echo -e "\033[1;36mAtualizando certificado SSL...\033[0m"; sleep 2; }
LIMPARVPS () { apt autoremove -y && apt autoclean -y; echo -e "\033[1;32mLimpeza concluída.\033[0m"; sleep 2; }
SINCPRO () { echo -e "\033[1;36mSincronização PRO...\033[0m"; sleep 2; }
SINCPLUS () { echo -e "\033[1;36mSincronização PLUS...\033[0m"; sleep 2; }

# ============================================================
# VALIDAÇÃO ANTECIPADA
# ============================================================
clear
echo -e "\033[1;34mVerificando autorização...\033[0m"
if ! obter_e_validar_chave; then
    echo -e "\033[1;31mChave inválida. Script encerrado.\033[0m"
    sleep 3
    clear
    exit 1
fi

# ============================================================
# Menu com banner compacto
# ============================================================
while true; do
    clear
    # Banner reduzido
    echo -e "\033[1;36m"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                   CYBERCOARI - SPEED E CONEXÃO              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "\033[0m"
    echo -e "\033[0;34m╔══════════════════════════════════════════════════════════════╗\033[0m"
    echo -e "\033[1;31m \E[1;31;40m                   ⇱ VELOCIDADE E CONEXAO ⇲                  \E[0m \033[1;37m"
    echo -e "\033[0;34m╠══════════════════════════════════════════════════════════════╣\033[0m"
    echo -e "\033[00;34m║\033[1;31m[\033[1;37m 01 •\033[1;31m]\033[1;37m ➩ \033[1;33m SSH CYBERCOARI PRO \033[0;32m                                 \033[00;34m║"
    echo -e "\033[00;34m║\033[1;31m[\033[1;37m 02 •\033[1;31m]\033[1;37m ➩ \033[1;33m SSH CYBERCOARI PLUS \033[0;32m                                \033[00;34m║"
    echo -e "\033[00;34m║\033[1;31m[\033[1;37m 03 •\033[1;31m]\033[1;37m ➩ \033[1;33m CYBERCOARI PREMIUM \033[0;32m                                 \033[00;34m║"
    echo -e "\033[00;34m║\033[1;31m[\033[1;37m 04 •\033[1;31m]\033[1;37m ➩ \033[1;33m PAINEL WEB CYBERCOARI PRO \033[0;32m                          \033[00;34m║"
    echo -e "\033[00;34m║\033[1;31m[\033[1;37m 05 •\033[1;31m]\033[1;37m ➩ \033[1;33m PAINEL WEB CYBERCOARI PLUS \033[0;32m                         \033[00;34m║"
    echo -e "\033[00;34m║\033[1;31m[\033[1;37m 06 •\033[1;31m]\033[1;37m ➩ \033[1;33m HABILITAR ROOT \033[0;32m                                    \033[00;34m║"
    echo -e "\033[00;34m║\033[1;31m[\033[1;37m 07 •\033[1;31m]\033[1;37m ➩ \033[1;33m ATUALIZAR CERTIFICADO SSL \033[0;32m                         \033[00;34m║"
    echo -e "\033[00;34m║\033[1;31m[\033[1;37m 08 •\033[1;31m]\033[1;37m ➩ \033[1;33m LIMPAR VPS \033[1;37m \033[0;32m                                       \033[00;34m║"
    echo -e "\033[00;34m║\033[1;31m[\033[1;37m 09 •\033[1;31m]\033[1;37m ➩ \033[1;37m MENU \033[0;32m                                              \033[00;34m║"
    echo -e "\033[0;34m╠══════════════════════════════════════════════════════════════╣\033[0m"
    echo -e "\033[0;34m║\033[5;34;47m     A ➩ SINC PRO   ║    B ➩ SINC PLUS    ║    C ➩ SAIR       \033[0m║\033[0m"
    echo -e "\033[0;34m╚══════════════════════════════════════════════════════════════╝\033[0m"
    echo -e ""
    echo -e "\033[0;34m╔══════════════════════════════════════════════════════════════╗\033[0m"
    echo -e "\033[1;31m \E[1;31;40m          COMPRE SUA KEY \033[1;36m(TELEGRAM)\033[1;31m: \033[1;37m@cybercoari1                  \E[0m \033[1;37m"
    echo -e "\033[0;34m╚══════════════════════════════════════════════════════════════╝\033[0m"
    echo -ne "\033[1;32m O QUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m : "
    read x

    case "$x" in
        c|C) echo -e "\033[1;31mSaindo...\033[0m"; sleep 2; clear; exit 0 ;;
        9|09) clear; continue ;;
        a|A) obter_e_validar_chave && SINCPRO ;;
        b|B) obter_e_validar_chave && SINCPLUS ;;
        [1-8])
            if ! obter_e_validar_chave; then
                echo -e "\033[1;31mAcesso negado.\033[0m"; sleep 2; continue
            fi
            case "$x" in
                1|01) SSHPRO ;; 2|02) SSHPLUS ;; 3|03) SSHPREMIUM ;;
                4|04) PWEBPRO ;; 5|05) PWEBPLUS ;; 6|06) HABILITARROOT ;;
                7|07) ATTSSL ;; 8|08) LIMPARVPS ;;
            esac
            echo -e "\033[1;32mConcluído. Pressione enter.\033[0m"; read -s
            ;;
        *) echo -e "\033[1;31mInválido.\033[0m"; sleep 2 ;;
    esac
done