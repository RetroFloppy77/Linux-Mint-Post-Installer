# Documentazione Script Post-Installazione (`lmpi.sh`)

---

## 👤 Informazioni sull'Autore

| Parametro | Dettaglio |
| :--- | :--- |
| **👤 Autore** | Stefano Peris |
| **🐙 GitHub** | [RetroFloppy77](https://github.com/RetroFloppy77) |
| **✉️ Email** | `stefanoperis.github@gmail.com` |
| **🐧 OS Supportato** | Linux Mint, Ubuntu e derivate Debian-based |
| **📜 Licenza** | MIT |

---

## 📖 Descrizione Generale

`lmpi.sh` (Linux Mint Post-Install) è uno script automatizzato in ambiente **Bash** progettato per configurare rapidamente una nuova installazione di Linux Mint o Ubuntu. Lo script automatizza l'aggiornamento del sistema, l'installazione di codec multimediali, strumenti di compilazione, runtime di programmazione, editor di codice e applicazioni grafiche sia tramite il gestore pacchetti nativo **APT** che tramite **Flatpak**.

Inoltre, gestisce in modo sicuro le configurazioni utente (come `pipx` e l'impostazione globale di **Git**) distinguendo tra i permessi di amministrazione `root` e l'utente reale che esegue lo script (`$SUDO_USER`).

---

## 🚀 Guida all'Uso da Terminale

Segui questi passaggi per scaricare, configurare ed eseguire lo script sul tuo sistema.

### Assegnazione dei Permessi di Esecuzione

Rendi lo script eseguibile con il comando `chmod`:

```bash
chmod +x lmpi.sh
```

### 3️⃣ Esecuzione dello Script

Esegui lo script avviandolo con i privilegi di amministratore (`sudo`):

```bash
sudo ./lmpi.sh
```

> ⚠️ **Nota Importante prima dell'esecuzione:**
> Prima di lanciare lo script, assicurati che il **Gestore Aggiornamenti** grafico non stia eseguendo controlli o installazioni in background per evitare blocchi al gestore pacchetti APT (`/var/lib/dpkg/lock-frontend`).

---

## 📦 Lista Pacchetti Software Installati

### 🎬 Codec & Multimedia
* 🎵 **`mint-meta-codecs`** (APT) — Pacchetto di meta-codec multimediali essenziali per la riproduzione di formati audio/video proprietari (MP3, MP4, DVD).
* 🎬 **`vlc`** (APT) — Lettore multimediale open source universale per qualsiasi formato audio e video.

---

### ⚙️ Utility di Sistema, Manutenzione & Archivi
* 💽 **`gparted`** (APT) — Gestore grafico per la partizione e formattazione di dischi rigidi, SSD e chiavette USB.
* 📊 **`htop`** (APT) — Monitor di sistema interattivo per terminale per la gestione del carico CPU, processi e RAM.
* 📈 **`btop`** (APT) — Monitor di sistema TUI moderno, avanzato e ricco di dettagli grafici per le risorse di sistema.
* 📦 **`synaptic`** (APT) — Gestore pacchetti grafico avanzato Debian/Ubuntu per installazioni a basso livello e risoluzione dipendenze.
* 🗜️ **`p7zip-full`** (APT) — Utility per la decompressione e creazione di archivi in formato 7z e 7za.
* 🔓 **`unrar`** (APT) — Estrattore di archivi compressi in formato RAR.
* 📦 **`zip`** (APT) — Strumento da riga di comando per creare file compressi `.zip`.
* 📂 **`unzip`** (APT) — Strumento da riga di comando per estrarre e decomprimere file `.zip`.

---

### 🎨 Produttività & Grafica
* 📸 **`flameshot`** (APT) — Strumento avanzato per la cattura di schermate con funzionalità di annotazione, sfocatura e testo.
* 🖌️ **`gimp`** (APT) — GNU Image Manipulation Program, la principale alternativa open source per il fotoritocco e la grafica raster.
* 🖊️ **`inkscape`** (APT) — Editor professionale di grafica vettoriale SVG, ideale per illustrazioni e schemi per documentazione.
* 🧊 **`goxel`** (APT) — Editor open source per la modellazione 3D in Voxel Art.
* 👾 **`LibreSprite`** (Flatpak: `ar.gertgermeraad.LibreSprite`) — Editor grafico specializzato in Pixel Art e animazioni sprite 2D.
* 📊 **`Draw.io`** (Flatpak: `com.diagrams.net.drawio`) — Applicazione per la creazione di diagrammi di flusso, mappe concettuali, schemi di rete ed ERD.

---

### 📄 Documentazione & Ambiente LaTeX
* 📚 **`texlive-full`** (APT) — Distribuzione LaTeX completa contenente tutti i pacchetti CTAN, font, compilatori (`pdflatex`, `lualatex`, `xelatex`) e moduli bibliografici (`biber`).
* 📝 **`texstudio`** (APT) — Ambiente di sviluppo integrato (IDE) avanzato dedicato alla scrittura di documenti LaTeX con anteprima PDF.

---

### 🛠️ Sviluppo & Runtime Linguaggi
* 🛠️ **`build-essential`** (APT) — Pacchetto contenente compilatori di base C/C++ (`gcc`, `g++`, `make`) necessari per la compilazione di sorgenti.
* 🐍 **`python3-pip`** (APT) — Gestore di pacchetti ufficiale per librerie e pacchetti Python.
* 📦 **`python3-venv`** (APT) — Modulo per la creazione e gestione di ambienti virtuali isolati in Python.
* 🐍 **`python3-full`** (APT) — Installazione completa della libreria standard e moduli essenziali di Python 3.
* ⚙️ **`python3-dev`** (APT) — Header di sviluppo e file di inclusione per compilare estensioni Python in C/C++.
* 🌙 **`lua5.4`** (APT) — Linguaggio di programmazione leggero, veloce ed estensibile (versione 5.4).
* 🪨 **`luarocks`** (APT) — Gestore di pacchetti e moduli ufficiali per il linguaggio Lua.
* 🚀 **`pipx`** (APT) — Strumento per installare ed eseguire applicazioni Python CLI isolate senza interferire con i pacchetti APT di sistema.

---

### 💻 Editor di Codice & Ambiente di Sviluppo
* 💙 **`VSCodium`** (Flatpak: `com.vscodium.codium`) — Versione completamente open source e libera da telemetria dell'editor Visual Studio Code.
* ⚡ **`neovim`** (APT) — Editor di testo estensibile basato su Vim da terminale, configurabile in Lua.

---

### 🔀 Controllo di Versione (Git)
* 🐙 **`git`** (APT) — Sistema di controllo versione distribuito per tracciare le modifiche al codice sorgente.
* 🐯 **`tig`** (APT) — Interfaccia utente testuale (TUI) basata su ncurses per navigare la cronologia Git ed i commit da terminale.

---

## 🛠️ Caratteristiche Tecniche dello Script

1. **Gestione Sicura dei Privilegi Utente (`$SUDO_USER`)**:
   Lo script individua automaticamente l'utente non-root che ha lanciato il comando `sudo`. In questo modo, operazioni come la configurazione dell'ambiente di `pipx` (`pipx ensurepath`) e la configurazione globale di Git (`git config --global`) vengono applicate direttamente al profilo dell'utente reale (`/home/username/`) e non alla cartella di `root`.
2. **Sicurezza di Esecuzione (`set -e`)**:
   Lo script include l'istruzione `set -e` per bloccare immediatamente l'esecuzione in caso di errore in uno dei comandi, evitando installazioni incomplete o inconsistenti.
3. **Repository Flatpak Autogestito**:
   Verifica automaticamente la presenza del gestore `flatpak` e aggiunge il repository ufficiale **Flathub** qualora non fosse già attivo sul sistema.
4. **Pulizia Automatica finale**:
   Al termine dell'installazione dei pacchetti, lo script effettua la pulizia delle dipendenze non più necessarie e della cache dei pacchetti tramite `apt autoremove -y` e `apt clean`.
