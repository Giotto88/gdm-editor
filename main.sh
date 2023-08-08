#!/usr/bin/env bash
# Autor: Giotto88, Github Copilot
# Version: 0.1
# Script per la modifica del tema di GDM3
#
# Fork originale: https://github.com/thiggy01/change-gdm-background
# =================================================================== #

# --------------------- FUNCIONS -------------------------

# Create directories from resource list.
CreateDirs() {
for resource in `gresource list "$gdm3Resource~"`; do
    resource="${resource#\/org\/gnome\/shell\/}"
    if [ ! -d "$workDir"/"${resource%/*}" ]; then
      mkdir -p "$workDir"/"${resource%/*}"
    fi
done
}

# Extract resources from binary file.
ExtractRes() {
for resource in `gresource list "$gdm3Resource~"`; do
    gresource extract "$gdm3Resource~" "$resource" > \
    "$workDir"/"${resource#\/org\/gnome\/shell\/}"
done
}

# Compile resources into a gresource binary file.
CompileRes() {
glib-compile-resources --sourcedir=$workDir/theme/ $workDir/theme/"$gdm3xml"
}

# Moves the newly created resource to its default place.
MoveRes() {
sudo -i mv $workDir/theme/gnome-shell-theme.gresource $gdm3Resource
}

# Check if gresource was sucessfuly moved to its default folder.
Check() {
if [ "$?" -eq 0 ]; then
    # If everything went well, remove backup file.
    # rm "$gdm3Resource~"
    # echo 'Changes applied successfully.'
    echo -e '\nModifiche caricate con successo.\nRiavviare il servizio GDM per applicare le modifiche.'
else
    # If something went wrong, restore backup file.
    echo 'qualcosa è andato storto.'
    read -p "Ripristinare backup? (Y/N): " response
    response=$(echo "$response" | tr '[:lower:]' '[:upper:]')      
    if [[ "$response" == "Y" || "$response" == "YES" ]]; then
        sudo -i mv "$gdm3Resource~" "$gdm3Resource"
        [ $? -eq 1 ] && echo ">> Errore"
        echo "YES"
    else
        echo "NO"
    fi 
    echo 'Il backup non è stato ripristinato.'
fi
}

CleanUp() {
    # Remove temporary directories and files.
    rm -r "$workDir"
    return $?
}

# --------------------- FUNCIONS -------------------------


# --------------------- VARIABLES -------------------------
    # Assign the default gdm theme file path.
    gdm3Resource=/usr/share/gnome-shell/theme/Yaru/gnome-shell-theme.gresource
    gdm3xml=$(basename "$gdm3Resource").xml
    workDir="/tmp/gdm3-theme"
# --------------------- VARIABLES -------------------------

# check if libglib2.0-dev is install in ubuntu
if ! dpkg -s libglib2.0-dev >/dev/null 2>&1; then
    echo "libglib2.0-dev non installato"
    echo "installazione in corso..."
    sudo apt install libglib2.0-dev
fi

while true; do

echo "  ______  _______  __       __      ________ _______  ______ ________  ______  _______   "
echo " /      \|       \|  \     /  \    |        \       \|      \        \/      \|       \  "
echo "|  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\ ▓▓\   /  ▓▓    | ▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓\\▓▓▓▓▓▓\▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\ "
echo "| ▓▓ __\▓▓ ▓▓  | ▓▓ ▓▓▓\ /  ▓▓▓    | ▓▓__   | ▓▓  | ▓▓ | ▓▓    | ▓▓  | ▓▓  | ▓▓ ▓▓__| ▓▓ "
echo "| ▓▓|    \ ▓▓  | ▓▓ ▓▓▓▓\  ▓▓▓▓    | ▓▓  \  | ▓▓  | ▓▓ | ▓▓    | ▓▓  | ▓▓  | ▓▓ ▓▓    ▓▓ "
echo "| ▓▓ \▓▓▓▓ ▓▓  | ▓▓ ▓▓\▓▓ ▓▓ ▓▓    | ▓▓▓▓▓  | ▓▓  | ▓▓ | ▓▓    | ▓▓  | ▓▓  | ▓▓ ▓▓▓▓▓▓▓\ "
echo "| ▓▓__| ▓▓ ▓▓__/ ▓▓ ▓▓ \▓▓▓| ▓▓    | ▓▓_____| ▓▓__/ ▓▓_| ▓▓_   | ▓▓  | ▓▓__/ ▓▓ ▓▓  | ▓▓ "
echo " \▓▓    ▓▓ ▓▓    ▓▓ ▓▓  \▓ | ▓▓    | ▓▓     \ ▓▓    ▓▓   ▓▓ \  | ▓▓   \▓▓    ▓▓ ▓▓  | ▓▓ "
echo "  \▓▓▓▓▓▓ \▓▓▓▓▓▓▓ \▓▓      \▓▓     \▓▓▓▓▓▓▓▓\▓▓▓▓▓▓▓ \▓▓▓▓▓▓   \▓▓    \▓▓▓▓▓▓ \▓▓   \▓▓ "
echo "                                                                                         "
echo -e "versione 0.1 \n\n"

echo -e "0\tEsci dal programma"
echo -e "STEP 1:\tPreparazione di file e cartelle"
echo -e "STEP 2:\tEstrazione dei file dal file binario"
echo -e "STEP 3:\tCompilazione del file"
echo -e "STEP 4:\tPulizia dei file non piu' necessari"
echo -e "STEP 5:\tRiavvio del servizio GDM"                                                                                  
echo ""
echo ""
# leggi il primo numero inserito da tastiera
read -p "Inserisci il numero della voce da eseguire: " -n 1 -r scelta


# --------------------------------------------------------- #

clear
    #display environment variables
    echo -e "GDM3 XML:\t $gdm3xml"
    echo -e "GDM3 Resource:\t $gdm3Resource"
    echo -e "Work Directory:\t $workDir \n\n"

case $scelta in
    0)
        exit 0
    ;;

    1)
    echo "STEP 1:   Preparazione di file e cartelle"
    echo ""  

    read -p "Cambiare le variabili d'ambiente? (Y/N): " response 
        if [[ "$response" == "Y" || "$response" == "YES" ]]; then

        # Change the default gdm theme file path if the user provides one.
        read -p "Inserisci il percorso del file gnome-shell-theme.gresource: " gdm3Resource
        # Check if the file exists.
        if [ ! -f "$gdm3Resource" ]; then
            echo "Il file $gdm3Resource non esiste."
            exit 1
        fi

        # Change the default Work Directory file path if the user provides one.
        read -p "Inserisci il percorso della cartella di lavoro: " workDir
        # Check if the file exists.
        if [ ! -d "$workDir" ]; then
            echo "La cartella $workDir non esiste."
            exit 1
        fi

        echo "YES"
    else
        echo "NO"
    fi


    # create work directory
    mkdir -p "$workDir"/theme

    # Create a backup file of the original theme if there isn't one. [optional]
    read -p "Creare un backup del file gnome-shell-theme.gresource? (Y/N): " response

    # Convert the response to uppercase for case-insensitivity
    response=$(echo "$response" | tr '[:lower:]' '[:upper:]')

    # Check if the response is 'Y' or 'YES', and set the exit code accordingly
    if [[ "$response" == "Y" || "$response" == "YES" ]]; then
        [ ! -f "$gdm3Resource"~ ] && cp "$gdm3Resource" "$gdm3Resource~"
        [ $? -eq 1 ] && echo ">> Errore"
        echo "YES"
    else
        echo "NO"
    fi

    #clean file with .css in /usr/share/gnome-shell/theme/Yaru? [optional]
    read -p "Pulire i file non utili di Yaru (css/svg)? (Y/N): " response
    response=$(echo "$response" | tr '[:lower:]' '[:upper:]')
    if [[ "$response" == "Y" || "$response" == "YES" ]]; then
        sudo -i rm /usr/share/gnome-shell/theme/Yaru/*.css
        sudo -i rm /usr/share/gnome-shell/theme/Yaru/*.svg
        [ $? -eq 1 ] && echo ">> Errore"
        echo "YES"
    else
        echo "NO"
    fi
    ;;

    2)
        echo "STEP 2:   Estrazione dei file dal file binario"
        echo ""


        # Call procedures to create directories and extract resources to them.
        CreateDirs
        ExtractRes

        echo "GDM CSS: $workDir"/theme/gdm.css

        read -p "Elencare i file in $workDir/theme? (Y/N): " response
        response=$(echo "$response" | tr '[:lower:]' '[:upper:]')      
        if [[ "$response" == "Y" || "$response" == "YES" ]]; then
            echo -e "$(ls -l -r "$workDir"/theme)\n"
            [ $? -eq 1 ] && echo ">> Errore"
            echo "YES"
        else
            echo "NO"
        fi  
        
        echo "modificare ora i file css in $workDir/theme prima dello step 3"    
    ;;

    3)
        echo "STEP 3:   Compilazione del file"
        echo ""

        # Wait for user input to continue.
        echo -e "[1/3] Generazione del file xml"
        read -p "Premi un tasto per continuare: " -n 1

        # Generate gresource xml file.
        echo '<?xml version="1.0" encoding="UTF-8"?>
        <gresources>
            <gresource prefix="/org/gnome/shell/theme">' > "$workDir"/theme/"$gdm3xml"
            for file in `gresource list "$gdm3Resource~"`; do
        	echo "        <file>${file#\/org\/gnome/shell\/theme\/}</file>" \
        	>> "$workDir"/theme/"$gdm3xml"
            done
            #TODO: aggiungere file addizionali come immagini, etcetera
            #echo "        <file>$imgFile</file>" >> "$workDir"/theme/"$gdm3xml"
            echo '    </gresource>
        </gresources>' >> "$workDir"/theme/"$gdm3xml"

        
        # Wait for user input to continue.
        echo -e "\n[2/3] Compilazione della nuova risorsa"
        read -p "Premi un tasto per continuare: " -n 1
        CompileRes

        echo -e "\n[3/3] Collocazione della nuova risorsa"
        read -p "Premi un tasto per continuare: " -n 1
        MoveRes

        # Check if everything was successful.
        Check

    ;;

    4)
        echo "STEP 4:   Pulizia dei file non piu' necessari"
        echo ""

        # Remove temporary files and exit.
        read -p "Vuoi pulire i file temporanei in $workDir? (Y/N): " response
        response=$(echo "$response" | tr '[:lower:]' '[:upper:]')

        if [[ "$response" == "Y" || "$response" == "YES" ]]; then
            CleanUp
            [ $? -eq 1 ] && echo ">> Errore"
            echo "YES"
        else
            echo "NO"
        fi
        

    ;;


    5)
        echo "STEP 5:   Riavvio del servizio GDM"     
        echo ""

        # Solve a permission change issue (thanks to @huepf from github).
        chmod 644 "$gdm3Resource"
        echo 'GDM background sucessfully changed.'
        read -p 'Do you want to restart gdm to apply change? (y/n):' -n 1
        echo
        # If change was successful apply ask for gdm restart.
        if [[ "$REPLY" =~ ^[yY]$ ]]; then
	        service gdm restart
        else
	        echo "Change will be applied only after restarting gdm"
	        echo
        fi
    ;;  


  *)
    echo "voce non valida"
    ;;


esac

done