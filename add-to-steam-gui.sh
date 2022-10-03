#!/bin/sh

INSTALLED_APPS_DIR=/tmp/.installed_apps/

add_to_steam() {
    encodedUrl="steam://addnonsteamgame/$(python3 -c "import urllib.parse;print(urllib.parse.quote(\"$1\", safe=''))")"
    touch /tmp/addnonsteamgamefile
    # zenity --info --text="Add to steam: ${encodedUrl}" #DEBUG
    xdg-open $encodedUrl
}

### prepare quick access applications directory
rm $INSTALLED_APPS_DIR/*
rmdir $INSTALLED_APPS_DIR
mkdir -p $INSTALLED_APPS_DIR
for i in /var/lib/flatpak/app/*/current/active/export/share/applications/* /usr/share/applications/*; do
    name=`cat $i | grep -m 1 "^Name="`
    ln -s $i $INSTALLED_APPS_DIR/"${name:5}"
done

### let user select application to add to Steam
add_to_steam_file=`zenity --file-selection --filename=$INSTALLED_APPS_DIR --title="Add to Steam"`
case $? in
         0)
                # zenity --info --text="Selected file: ${add_to_steam_file}" #DEBUG
                if [[ "$add_to_steam_file" == $INSTALLED_APPS_DIR* ]]
                then
                    # resolve symlink of quick access desktop files
                    add_to_steam_file=`readlink "$add_to_steam_file"` 
                    # zenity --info --text="Resolved link: ${add_to_steam_file}" #DEBUG
                fi
                add_to_steam "$add_to_steam_file"
                ;;
         1)
                zenity --info --text="No file selected.";;
         *)
                zenity --error --text="An unexpected error has occurred.";;
esac
