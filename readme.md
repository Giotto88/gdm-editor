```
  ______  _______  __       __      ________ _______  ______ ________  ______  _______   
 /      \|       \|  \     /  \    |        \       \|      \        \/      \|       \  
|  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\ ▓▓\   /  ▓▓    | ▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓\\▓▓▓▓▓▓\▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\ 
| ▓▓ __\▓▓ ▓▓  | ▓▓ ▓▓▓\ /  ▓▓▓    | ▓▓__   | ▓▓  | ▓▓ | ▓▓    | ▓▓  | ▓▓  | ▓▓ ▓▓__| ▓▓ 
| ▓▓|    \ ▓▓  | ▓▓ ▓▓▓▓\  ▓▓▓▓    | ▓▓  \  | ▓▓  | ▓▓ | ▓▓    | ▓▓  | ▓▓  | ▓▓ ▓▓    ▓▓ 
| ▓▓ \▓▓▓▓ ▓▓  | ▓▓ ▓▓\▓▓ ▓▓ ▓▓    | ▓▓▓▓▓  | ▓▓  | ▓▓ | ▓▓    | ▓▓  | ▓▓  | ▓▓ ▓▓▓▓▓▓▓\ 
| ▓▓__| ▓▓ ▓▓__/ ▓▓ ▓▓ \▓▓▓| ▓▓    | ▓▓_____| ▓▓__/ ▓▓_| ▓▓_   | ▓▓  | ▓▓__/ ▓▓ ▓▓  | ▓▓ 
 \▓▓    ▓▓ ▓▓    ▓▓ ▓▓  \▓ | ▓▓    | ▓▓     \ ▓▓    ▓▓   ▓▓ \  | ▓▓   \▓▓    ▓▓ ▓▓  | ▓▓ 
  \▓▓▓▓▓▓ \▓▓▓▓▓▓▓ \▓▓      \▓▓     \▓▓▓▓▓▓▓▓\▓▓▓▓▓▓▓ \▓▓▓▓▓▓   \▓▓    \▓▓▓▓▓▓ \▓▓   \▓▓ 
```
# GDM Editor

> ⚠⚠ Ovviamente, è una demo ancora in fase di sviluppo. Assicurasi un backup del sistema prima dell'uso!! L'utilizzo è pensato per macchine virtuali! ⚠⚠

Lo script è stato realizzato per agevolare la modifica della compilazione dei fogli di stile di gnome-shell.
Le funzioni si basano sull'fork di [Thiago Silva](https://github.com/thiggy01/change-gdm-background)

Una guida su come modificare il foglio di stile gdm.css è ancora in fase di stesura.

```bash
wget https://raw.githubusercontent.com/Giotto88/gdm-editor/main/main.sh && bash main.sh
```

### Alcune note:
- Lo script è stato testato su Ubuntu 22.10
- Lo script richiede l'autoruizzazione di root per poter modificare alcuni file di sistema
- Lo script richiede l'installazione di alcuni pacchetti
    - libglib2.0-dev (per la compilazione di sassc)

### Funzionalità future:
- [ ] Traduzione in inglese
- [x] Modifica dei percorsi predefiniti
- [ ] Supporto per Fedora e Pop os
- [ ] Aggiungere la possibilità di modificare il foglio di stile di gdm
- [x] Controllo delle dipendenze richieste dallo script (libglib2.0-dev)

### Post scriptum:
#### Tipi di file CSS
> Il file **gdm.css** contiene le regole di stile CSS che determinano l'aspetto dell'interfaccia di accesso di GDM per _l'accesso al sistema_.

> Il file **gnome-shell.css**, che è utilizzato per modificare l'aspetto dell'_interfaccia utente del desktop GNOME_ dopo l'accesso. 

Quindi, le modifiche a gdm.css riguarderanno solo l'interfaccia di accesso di GDM, mentre le modifiche a gnome-shell.css influenzeranno l'aspetto dell'interfaccia utente di GNOME dopo il login.

#### Altro
Si consideri che ogni volta che viene estratto il tema (step 2), i file presenti nella cartella sono quelli di default di gnome-shell. Per questo motivo, se si vuole modificare il tema, è necessario modificare i file presenti nella cartella estratta e non quelli presenti nella cartella del tema.