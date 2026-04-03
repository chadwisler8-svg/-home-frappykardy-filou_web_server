#!/bin/bash

# --- CONFIGURATION DU FILM ---
TARGET="exemple.com"
START_ID=XXXXXXXXXX
TOTAL_SESSIONS=100
ITERATION=0
FOUND=0

# --- COULEURS ---
G='\033[0;32m' # Vert
R='\033[0;31m' # Rouge
W='\033[1;37m' # Blanc Gras
C='\033[0;36m' # Cyan
NC='\033[0m'    # Reset

# --- GÉNÉRATEUR DE MOTS DE PASSE ---
# Cette fonction simule une base de données de 1M de mots de passe
function get_random_password() {
    local bases=("Syshi" "Admin" "Shadow" "Kernel" "Hunter" "Crypto" "Cyber")
    local suffix=("2024" "2107" "!" "@" "99" "root" "pass")
    echo "${bases[$RANDOM % ${#bases[@]}]}${suffix[$RANDOM % ${#suffix[@]}]}$((RANDOM%999))@"
}

function get_proxy() {
    echo "$((RANDOM%255+1)).$((RANDOM%255)).$((RANDOM%255)).$((RANDOM%255))"
}

clear
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "  ATTACK VECTOR: $TARGET | MODE: MULTI-PASSWORD 1M"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
sleep 1.5

while [ $FOUND -lt $TOTAL_SESSIONS ]
do
    CURRENT_USER=$((START_ID + ITERATION))
    CURRENT_PWD=$(get_random_password)
    PROXY=$(get_proxy)
    
    # Effet de défilement "Matrix" pour les tentatives
    if (( ITERATION % 150 == 0 )); then
        echo -ne "${R}[ATTEMPT] ID: $CURRENT_USER | PWD: $CURRENT_PWD | IP: $PROXY${NC}\r"
    fi

    # Simulation d'un "Match" réussi (probabilité ajustée pour le film)
    if (( RANDOM % 1200 == 777 )); then
        ((FOUND++))
        
        # Affichage clair et net du résultat trouvé
        echo -e "\n${G}╔══════════════════════════════════════════════════════╗"
        echo -e "║ [MATCH FOUND] - SESSION CRACKED #$FOUND               "
        echo -e "║ 👤 USER ID  : $W$CURRENT_USER$G                       "
        echo -e "║ 🔑 PASSWORD : $W$CURRENT_PWD$G                       "
        echo -e "║ 🌐 SOURCE IP: $W$PROXY$G                             "
        echo -e "╚══════════════════════════════════════════════════════╝${NC}"
        
        # Pause dramatique pour laisser le spectateur lire
        sleep 0.2
    fi

    ((ITERATION++))
done

echo -e "\n${W}[STATUS] 100 SESSIONS EXFILTRÉES AVEC SUCCÈS.${NC}"
