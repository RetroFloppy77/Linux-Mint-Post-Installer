#!/bin/bash

# ==============================================================================
# SCRIPT DI POST-INSTALLAZIONE PER LINUX MINT
# Setup completo di utility, editor, Python, LaTeX e Controllo Versione (Git).
#
# Autore: Stefano Peris
# Github: https://github.com/RetroFloppy77
# email: stefanoperis.github@gmail.com
# ==============================================================================

# Blocco di sicurezza: interrompe lo script in caso di errori imprevisti
set -e

echo "=========================================================="
# Richiede i privilegi di amministratore all'inizio per evitare interruzioni continue
echo "Richiesta privilegi di amministratore. Inserisci la password:"
sudo -v

echo "Aggiornamento dei repository del sistema..."
sudo apt update && sudo apt upgrade -y
echo "=========================================================="

# ------------------------------------------------------------------------------
# 1. CODEC E MULTIMEDIA
# ------------------------------------------------------------------------------

echo "Installazione: mint-meta-codecs..."
# mint-meta-codecs: Installa i codec essenziali (MP3, MP4, DVD, Flash) per la
# riproduzione di file multimediali proprietari. Fondamentale per l'intrattenimento.
sudo apt install mint-meta-codecs -y

echo "Installazione: VLC Media Player..."
# vlc: Il lettore multimediale definitivo open source. Riproduce qualsiasi formato
# audio e video esistente senza bisogno di configurazioni aggiuntive.
sudo apt install vlc -y

# ------------------------------------------------------------------------------
# 2. UTILITY DI SISTEMA E MANUTENZIONE
# ------------------------------------------------------------------------------

echo "Installazione: GParted..."
# gparted: Editor grafico di partizioni. Permette di ridimensionare, creare,
# controllare e formattare dischi fissi, SSD e chiavette USB in sicurezza.
sudo apt install gparted -y

echo "Installazione: htop e btop..."
# htop / btop: Monitor di sistema interattivi per il terminale. Mostrano l'uso
# di CPU, memoria RAM, processi e dischi con un'interfaccia a colori avanzata.
sudo apt install htop btop -y

echo "Installazione: Synaptic..."
# synaptic: Il gestore pacchetti grafico avanzato "storico" di Debian/Ubuntu.
# Utile per installazioni di basso livello o per risolvere problemi di dipendenze.
sudo apt install synaptic -y

# ------------------------------------------------------------------------------
# 3. PRODUTTIVITÀ E GRAFICA
# ------------------------------------------------------------------------------

echo "Installazione: Flameshot..."
# flameshot: Strumento di cattura schermate avanzato. Permette di annotare,
# disegnare frecce, sfocare dati sensibili ed editare lo screenshot prima di salvarlo.
sudo apt install flameshot -y

echo "Installazione: GIMP..."
# gimp: GNU Image Manipulation Program. La principale alternativa open source
# a Photoshop per il fotoritocco e la grafica raster.
sudo apt install gimp -y

echo "Installazione: Inkscape..."
# inkscape: Editor di grafica vettoriale open source professionale. Ottimo per
# creare illustrazioni e schemi scientifici da importare in LaTeX.
sudo apt install inkscape -y

# ------------------------------------------------------------------------------
# 4. AMBIENTE LATEX COMPLETO (TEX LIVE)
# ------------------------------------------------------------------------------

echo "Installazione: TeX Live Full (LaTeX)..."
# texlive-full: La distribuzione LaTeX completa per Linux. Include pdflatex,
# xelatex, lualatex, biber, tutti i font e i pacchetti di stile (CTAN).
# Nota: richiede alcuni minuti e circa 4 GB di spazio su disco.
sudo apt install texlive-full -y

# ------------------------------------------------------------------------------
# 5. CONTROLLO VERSIONE (GIT)
# ------------------------------------------------------------------------------

echo "Installazione: Git e utility per il terminale..."
# git: Il sistema di controllo versione distribuito più usato al mondo.
# Fondamentale per tracciare le modifiche ai tuoi script Python, Bash, Lua e file LaTeX.
# tig: Un'ottima interfaccia testuale (TUI) per Git che permette di navigare
# tra i commit e i rami direttamente dal terminale in modo visivo.
sudo apt install git tig -y

# ------------------------------------------------------------------------------
# 6. SVILUPPO (PYTHON, BASH, LUA, EDITOR)
# ------------------------------------------------------------------------------

echo "Installazione: Strumenti di compilazione di sistema (build-essential)..."
# build-essential: Installa i compilatori base (gcc, g++, make) necessari
# per compilare sorgenti o installare particolari moduli Python/Lua scritti in C.
sudo apt install build-essential -y

echo "Installazione: Pacchetti di sistema essenziali per Python 3..."
# python3-pip: Il generatore di pacchetti ufficiale per installare librerie Python.
# python3-venv: Modulo nativo per creare ambienti virtuali isolati per i progetti.
# python3-full: Include l'intera libreria standard di Python per evitare componenti mancanti.
# python3-dev: Header di sviluppo necessari per compilare estensioni Python in C.
sudo apt install python3-pip python3-venv python3-full python3-dev -y

echo "Installazione: pipx..."
# pipx: Strumento per installare ed eseguire applicazioni Python isolate in
# ambienti globali senza andare in conflitto con i pacchetti gestiti da APT di Mint.
sudo apt install pipx -y
pipx ensurepath

echo "Installazione: Neovim..."
# neovim: Versione moderna e potenziata dell'editor Vim da terminale. Usa Lua
# come linguaggio nativo di configurazione ed è perfetto per modifiche rapide.
sudo apt install neovim -y

echo "Installazione: TeXstudio..."
# texstudio: Ambiente di sviluppo integrato (IDE) specifico per LaTeX. Si interfaccia
# nativamente con texlive-full per offrire autocompletamento e anteprima PDF.
sudo apt install texstudio -y

# ------------------------------------------------------------------------------
# 7. PACCHETTI FLATPAK (DIAGRAMMI E SVILUPPO)
# ------------------------------------------------------------------------------

echo "Installazione pacchetti Flatpak: VSCodium e Draw.io..."
# flatpak install vscodium: Versione 100% open source di VS Code senza la
# telemetria di Microsoft. Supporta tutte le estensioni per Python, Bash, LaTeX e Lua.
flatpak install flathub com.vscodium.codium -y

# flatpak install draw.io: Il miglior software open source moderno per creare
# diagrammi di flusso, schemi di rete, database e grafici drag-and-drop.
flatpak install flathub com.diagrams.net.drawio -y

# ------------------------------------------------------------------------------
# PULIZIA FINALE E CONFIGURAZIONE FACOLTATIVA DI GIT
# ------------------------------------------------------------------------------

echo "Esecuzione pulizia finale del sistema..."
sudo apt autoremove -y && sudo apt clean

echo "=========================================================="
echo "CONFIGURAZIONE OPZIONALE DI GIT"
echo "=========================================================="
read -p "Vuoi configurare adesso il tuo Nome e la tua Email globali per Git? (s/n): " scelta

if [[ "$scelta" =~ ^[Ss]$ ]]; then
    read -p "Inserisci il tuo Nome e Cognome (es. Mario Rossi): " git_name
    read -p "Inserisci la tua Email di Git (es. mario.rossi@email.com): " git_email
    
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    
    echo "Git configurato con successo!"
    echo "Nome: $(git config --global user.name)"
    echo "Email: $(git config --global user.email)"
else
    echo "Configurazione di Git saltata. Potrai farla manualmente in seguito."
fi

echo "=========================================================="
echo "Installazione completata con successo! Il tuo ambiente è pronto."
echo "=========================================================="
