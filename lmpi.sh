#!/bin/bash

# ==============================================================================
# SCRIPT DI POST-INSTALLAZIONE PER LINUX MINT
# Setup completo di utility, editor, Python, Lua, LaTeX, Grafica, Archivi e Git.
#
# Autore: Stefano Peris
# Github: https://github.com/RetroFloppy77
# email:  stefanoperis.github@gmail.com
# ==============================================================================

# Blocco di sicurezza: interrompe lo script in caso di errori imprevisti
set -e

# Controllo privilegi di root
if [ "$EUID" -ne 0 ]; then
  echo "[-] Errore: Esegui questo script con i privilegi di root (sudo ./lmpi.sh)"
  exit 1
fi

# Rilevamento automatico dell'utente reale (non root) che ha avviato sudo
REAL_USER="${SUDO_USER:-$(logname 2>/dev/null || awk '{print $1}' < <(whoami))}"
if [ "$REAL_USER" = "root" ]; then
    REAL_USER=$(awk -F: '$3>=1000 && $3<65535 {print $1; exit}' /etc/passwd)
fi

echo "=========================================================="
echo "Avvio post-installazione per l'utente: $REAL_USER"
echo "Aggiornamento dei repository del sistema..."
apt update && apt upgrade -y
echo "=========================================================="

# ------------------------------------------------------------------------------
# 1. CODEC E MULTIMEDIA
# ------------------------------------------------------------------------------

echo "Installazione: mint-meta-codecs..."
# mint-meta-codecs: Installa i codec essenziali (MP3, MP4, DVD) per la
# riproduzione di file multimediali proprietari.
apt install mint-meta-codecs -y

echo "Installazione: VLC Media Player..."
# vlc: Il lettore multimediale definitivo open source.
apt install vlc -y

# ------------------------------------------------------------------------------
# 2. UTILITY DI SISTEMA, MANUTENZIONE E ARCHIVI
# ------------------------------------------------------------------------------

echo "Installazione: GParted..."
# gparted: Editor grafico di partizioni per dischi, SSD e chiavette USB.
apt install gparted -y

echo "Installazione: htop e btop..."
# htop / btop: Monitor di sistema interattivi per il terminale.
apt install htop btop -y

echo "Installazione: Synaptic..."
# synaptic: Il gestore pacchetti grafico avanzato di Debian/Ubuntu.
apt install synaptic -y

echo "Installazione: Utility per archivi e compressione (p7zip, unrar, zip, unzip)..."
# p7zip-full, unrar, zip, unzip: Strumenti essenziali per la gestione di file
# compressi (.zip, .rar, .7z) da riga di comando e integrati nel file manager.
apt install p7zip-full unrar zip unzip -y

# ------------------------------------------------------------------------------
# 3. PRODUTTIVITÀ E GRAFICA
# ------------------------------------------------------------------------------

echo "Installazione: Flameshot..."
# flameshot: Strumento di cattura schermate avanzato con annotazioni.
apt install flameshot -y

echo "Installazione: GIMP..."
# gimp: GNU Image Manipulation Program per il fotoritocco.
apt install gimp -y

echo "Installazione: Inkscape..."
# inkscape: Editor di grafica vettoriale professionale.
apt install inkscape -y

echo "Installazione: Goxel..."
# goxel: Editor open source di voxel 3D per modellazione geometrica.
apt install goxel -y

# ------------------------------------------------------------------------------
# 4. AMBIENTE LATEX COMPLETO (TEX LIVE)
# ------------------------------------------------------------------------------

echo "Installazione: TeX Live Full (LaTeX)..."
# texlive-full: La distribuzione LaTeX completa (richiede circa 4 GB).
apt install texlive-full -y

# ------------------------------------------------------------------------------
# 5. CONTROLLO VERSIONE (GIT)
# ------------------------------------------------------------------------------

echo "Installazione: Git e utility per il terminale..."
# git e tig: Controllo versione e interfaccia TUI per navigare tra i commit.
apt install git tig -y

# ------------------------------------------------------------------------------
# 6. SVILUPPO (PYTHON, BASH, LUA, EDITOR)
# ------------------------------------------------------------------------------

echo "Installazione: Strumenti di compilazione di sistema (build-essential)..."
# build-essential: Compilatori base (gcc, g++, make).
apt install build-essential -y

echo "Installazione: Pacchetti di sistema essenziali per Python 3..."
# python3-pip, venv, full, dev per la gestione completa di Python.
apt install python3-pip python3-venv python3-full python3-dev -y

echo "Installazione: Lua 5.4 e Luarocks..."
# lua5.4 e luarocks: Linguaggio di scripting e gestore di pacchetti Lua.
apt install lua5.4 luarocks -y

echo "Installazione: pipx..."
# pipx: Installazione ed esecuzione di app Python in ambienti isolati.
apt install pipx -y

# Esegue ensurepath come utente reale (non root)
echo "Configurazione di pipx per l'utente $REAL_USER..."
sudo -u "$REAL_USER" pipx ensurepath

echo "Installazione: Neovim..."
# neovim: Editor da terminale moderno basato su Lua.
apt install neovim -y

echo "Installazione: TeXstudio..."
# texstudio: IDE specifico per LaTeX con autocompletamento e anteprima PDF.
apt install texstudio -y

# ------------------------------------------------------------------------------
# 7. PACCHETTI FLATPAK (DIAGRAMMI, EDITOR E SVILUPPO)
# ------------------------------------------------------------------------------

echo "Installazione pacchetti Flatpak (VSCodium, Draw.io e LibreSprite)..."
# Assicura la presenza di Flatpak e del repository Flathub
if ! command -v flatpak &> /dev/null; then
    apt install -y flatpak
fi
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# VSCodium (Versione 100% open source di VS Code)
flatpak install flathub com.vscodium.codium -y

# Draw.io (Creazione di diagrammi e schemi)
flatpak install flathub com.diagrams.net.drawio -y

# LibreSprite (Editor di pixel art e animazioni)
flatpak install flathub ar.gertgermeraad.LibreSprite -y

# ------------------------------------------------------------------------------
# PULIZIA FINALE E CONFIGURAZIONE FACOLTATIVA DI GIT
# ------------------------------------------------------------------------------

echo "Esecuzione pulizia finale del sistema..."
apt autoremove -y && apt clean

echo "=========================================================="
echo "CONFIGURAZIONE OPZIONALE DI GIT"
echo "=========================================================="
read -p "Vuoi configurare adesso il tuo Nome e la tua Email globali per Git? (s/n): " scelta

if [[ "$scelta" =~ ^[Ss]$ ]]; then
    read -p "Inserisci il tuo Nome e Cognome (es. Mario Rossi): " git_name
    read -p "Inserisci la tua Email di Git (es. mario.rossi@email.com): " git_email

    # Configura Git per l'utente reale (salvando in ~/.gitconfig dell'utente)
    sudo -u "$REAL_USER" git config --global user.name "$git_name"
    sudo -u "$REAL_USER" git config --global user.email "$git_email"

    echo "Git configurato con successo per $REAL_USER!"
    echo "Nome: $(sudo -u "$REAL_USER" git config --global user.name)"
    echo "Email: $(sudo -u "$REAL_USER" git config --global user.email)"
else
    echo "Configurazione di Git saltata. Potrai farla manualmente in seguito."
fi

echo "=========================================================="
echo "Installazione completata con successo! Il tuo ambiente è pronto."
echo "=========================================================="
