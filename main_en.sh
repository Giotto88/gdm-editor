#!/usr/bin/env bash
# Autor: Giotto88, Github Copilot
# Version: 0.1 EN
# Scripts for editing the theme of GDM3
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
    echo -e '\nChanges successfully loaded.\nRestart the GDM service to apply the changes.'
else
    # If something went wrong, restore backup file.
    echo 'Something went wrong.'
    read -p "Restore backup? (Y/N): " response
    response=$(echo "$response" | tr '[:lower:]' '[:upper:]')      
    if [[ "$response" == "Y" || "$response" == "YES" ]]; then
        sudo -i mv "$gdm3Resource~" "$gdm3Resource"
        [ $? -eq 1 ] && echo ">> Error"
        echo "YES"
    else
        echo "NO"
    fi 
    echo 'The backup has not been restored.'
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
    echo "libglib2.0-dev not installed"
    echo "installation in progress..."
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
echo -e "version 0.1 \n\n"

echo -e "0\tExit"
echo -e "STEP 1:\tPreparation of files and folders"
echo -e "STEP 2:\tExtracting files from the binary file"
echo -e "STEP 3:\tCompiling the binary file"
echo -e "STEP 4:\tCleaning up files no longer needed"
echo -e "STEP 5:\tRestart of GDM service"                                                                                  
echo ""
echo ""
# leggi il primo numero inserito da tastiera
read -p "Enter the number of the line to be performed: " -n 1 -r scelta


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
    echo "STEP 1:   Preparation of files and folders"
    echo ""  

    read -p "Change environment variables? (Y/N): " response 
        if [[ "$response" == "Y" || "$response" == "YES" ]]; then

        # Change the default gdm theme file path if the user provides one.
        read -p "Enter the path to the file gnome-shell-theme.gresource:" gdm3Resource
        # Check if the file exists.
        if [ ! -f "$gdm3Resource" ]; then
            echo "Il file $gdm3Resource non esiste."
            exit 1
        fi

        # Change the default Work Directory file path if the user provides one.
        read -p "Enter workbook path: " workDir
        # Check if the file exists.
        if [ ! -d "$workDir" ]; then
            echo "The folder $workDir do not exist."
            exit 1
        fi

        echo "YES"
    else
        echo "NO"
    fi


    # create work directory
    mkdir -p "$workDir"/theme

    # Create a backup file of the original theme if there isn't one. [optional]
    read -p "Create a backup of the file gnome-shell-theme.gresource? (Y/N): " response

    # Convert the response to uppercase for case-insensitivity
    response=$(echo "$response" | tr '[:lower:]' '[:upper:]')

    # Check if the response is 'Y' or 'YES', and set the exit code accordingly
    if [[ "$response" == "Y" || "$response" == "YES" ]]; then
        [ ! -f "$gdm3Resource"~ ] && cp "$gdm3Resource" "$gdm3Resource~"
        [ $? -eq 1 ] && echo ">> Error"
        echo "YES"
    else
        echo "NO"
    fi

    #clean file with .css in /usr/share/gnome-shell/theme/Yaru? [optional]
    read -p "Clean up Yaru's unnecessary files (css/svg)? (Y/N): " response
    response=$(echo "$response" | tr '[:lower:]' '[:upper:]')
    if [[ "$response" == "Y" || "$response" == "YES" ]]; then
        sudo -i rm /usr/share/gnome-shell/theme/Yaru/*.css
        sudo -i rm /usr/share/gnome-shell/theme/Yaru/*.svg
        [ $? -eq 1 ] && echo ">> Error"
        echo "YES"
    else
        echo "NO"
    fi
    ;;

    2)
        echo "STEP 2:   Extracting files from the binary file"
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
        
        echo "Edit now the css files in $workDir/theme before step 3"    
    ;;

    3)
        echo "STEP 3:   Compiling the binary file"
        echo ""

        # Wait for user input to continue.
        echo -e "[1/3] Generation of the xml file"
        read -p "Press a key to continue: " -n 1

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
        echo -e "\n[2/3] Compiling the new resource"
        read -p "Press a key to continue: " -n 1
        CompileRes

        echo -e "\n[3/3] Setting up the new resource"
        read -p "Press a key to continue: " -n 1
        MoveRes

        # Check if everything was successful.
        Check

    ;;

    4)
        echo "STEP 4:   Cleaning up files no longer needed"
        echo ""

        # Remove temporary files and exit.
        read -p "Do you want to clean temporary files in $workDir? (Y/N): " response
        response=$(echo "$response" | tr '[:lower:]' '[:upper:]')

        if [[ "$response" == "Y" || "$response" == "YES" ]]; then
            CleanUp
            [ $? -eq 1 ] && echo ">> Error"
            echo "YES"
        else
            echo "NO"
        fi
        

    ;;


    5)
        echo "STEP 5:   Restart of GDM service"     
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
    echo "Invalid entry"
    ;;


esac

done