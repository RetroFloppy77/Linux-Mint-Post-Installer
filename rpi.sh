#!/bin/bash

# ==============================================================================
# SCRIPT DI POST-INSTALLAZIONE PER RASPBERRY PI 5 (RASPBERRY PI OS)
# Setup di utility, browser, Python, Lua, Neovim, Micro, Git, Okular e VSCodium.
#
# Autore: Stefano Peris
# Github: https://github.com/RetroFloppy77
# email:  stefanoperis.github@gmail.com
# ==============================================================================

# Blocco di sicurezza: interrompe lo script in caso di errori imprevisti
set -e

# Controllo privilegi di root
if [ "$EUID" -ne 0 ]; then
  echo "[-] Errore: Esegui questo script con i privilegi di root (sudo ./rpi5_setup.sh)"
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
apt update && apt full-upgrade -y
echo "=========================================================="

# ------------------------------------------------------------------------------
# 1. COMPILAZIONE E SISTEMA
# ------------------------------------------------------------------------------

echo "Installazione: Strumenti di compilazione di sistema (build-essential)..."
# build-essential: Compilatori base (gcc, g++, make).
apt install build-essential -y

# ------------------------------------------------------------------------------
# 2. TOOLCHAIN DI SVILUPPO C/C++ E SISTEMI DI BUILD
# ------------------------------------------------------------------------------

echo "Installazione: Strumenti avanzati di compilazione, debug e librerie di sviluppo..."
# cmake, ninja-build, meson, autoconf, automake, libtool: Sistemi e gestori di build.
# clang, pkg-config: Compilatore alternativo e utility di configurazione librerie.
# gdb, valgrind: Strumenti di debugging e analisi della memoria.
# libssl-dev, zlib1g-dev: Librerie di sviluppo per crittografia e compressione.
apt install cmake ninja-build meson autoconf automake libtool clang pkg-config gdb valgrind libssl-dev zlib1g-dev -y

# ------------------------------------------------------------------------------
# 3. BROWSER WEB
# ------------------------------------------------------------------------------

echo "Installazione: Chromium Browser..."
# chromium: Browser web open source.
apt install chromium -y

# ------------------------------------------------------------------------------
# 4. UTILITY E MONITORAGGIO DI SISTEMA
# ------------------------------------------------------------------------------

echo "Installazione: GParted e Htop..."
# gparted: Editor grafico di partizioni per dischi, SSD e schede SD.
# htop: Monitor di sistema interattivo per la gestione delle risorse da terminale.
apt install gparted htop -y

# ------------------------------------------------------------------------------
# 5. GESTIONE ARCHIVI E COMPRESSIONE
# ------------------------------------------------------------------------------

echo "Installazione: Utility per archivi e compressione (zip, unzip, unrar, p7zip-full)..."
# zip, unzip: Creazione ed estrazione di file .zip.
# unrar: Estrazione di archivi .rar.
# p7zip-full: Strumento di compressione ad alte prestazioni per formati .7z.
apt install zip unzip unrar p7zip-full -y

# ------------------------------------------------------------------------------
# 6. CONTROLLO VERSIONE (GIT)
# ------------------------------------------------------------------------------

echo "Installazione: Git..."
# git: Sistema di controllo versione distribuito.
apt install git -y

# ------------------------------------------------------------------------------
# 7. LETTURA DOCUMENTI E PDF (OKULAR)
# ------------------------------------------------------------------------------

echo "Installazione: Okular..."
# okular: Visualizzatore di documenti universale (PDF, EPUB, ecc.).
apt install okular -y

# ------------------------------------------------------------------------------
# 8. AMBIENTE PYTHON (PYTHON 3.12+, PIP, PIPX)
# ------------------------------------------------------------------------------

echo "Installazione: Pacchetti di sistema essenziali per Python 3..."
# python3-pip, venv, full, dev per la gestione completa di Python.
apt install python3-pip python3-venv python3-full python3-dev -y

echo "Installazione: pipx..."
# pipx: Installazione ed esecuzione di app Python in ambienti isolati.
apt install pipx -y

# Esegue ensurepath come utente reale (non root)
echo "Configurazione di pipx per l'utente $REAL_USER..."
sudo -u "$REAL_USER" pipx ensurepath

# ------------------------------------------------------------------------------
# 9. LUA E LUAROCKS
# ------------------------------------------------------------------------------

echo "Installazione: Lua e Luarocks..."
# lua5.4 e luarocks: Linguaggio di scripting e gestore di pacchetti Lua.
apt install lua5.4 luarocks -y

# ------------------------------------------------------------------------------
# 10. EDITOR E STRUMENTI DI SVILUPPO
# ------------------------------------------------------------------------------

echo "Installazione: Neovim e Micro..."
# neovim: Editor da terminale moderno basato su Lua.
# micro: Editor di testo da terminale moderno, intuitivo e con supporto al mouse.
apt install neovim micro -y

# ------------------------------------------------------------------------------
# 11. PACCHETTI FLATPAK (VSCODIUM)
# ------------------------------------------------------------------------------

echo "Installazione pacchetto Flatpak (VSCodium)..."
# Assicura la presenza di Flatpak tramite apt
if ! command -v flatpak &> /dev/null; then
    apt install -y flatpak
fi

# Configura il repository Flathub e installa VSCodium nel contesto dell'utente reale
sudo -u "$REAL_USER" flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo -u "$REAL_USER" flatpak install --user flathub com.vscodium.codium -y

# ------------------------------------------------------------------------------
# PULIZIA FINALE
# ------------------------------------------------------------------------------

echo "Esecuzione pulizia finale del sistema..."
apt autoremove -y && apt clean

echo "=========================================================="
echo "Installazione completata con successo! Il tuo Raspberry Pi 5 è pronto."
echo "=========================================================="
