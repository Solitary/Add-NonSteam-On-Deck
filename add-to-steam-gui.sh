#!/bin/sh

INSTALLED_APPS_DIR=/tmp/.installed_apps/

add_to_steam() {
    encodedUrl="steam://addnonsteamgame/$(python3 -c "import urllib.parse;print(urllib.parse.quote(\"$1\", safe=''))")"
    touch /tmp/addnonsteamgamefile
    # zenity --info --text="Add to steam: ${encodedUrl}" #DEBUG
    xdg-open $encodedUrl
}

create_desktop_file()
{
    name=$(basename "$1")
    desktop_file="/tmp/$name.desktop"
    cat << EOF > "$desktop_file"
[Desktop Entry]
Type=Application
Name=$name
Exec="$1"
EOF
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
                    add_to_steam_file=`readlink "$add_to_steam_file"`
                    # zenity --info --text="Resolved link: ${add_to_steam_file}" #DEBUG
                fi
                grep -l "\[Desktop Entry\]" "$add_to_steam_file"
                result=$?
                if [[ $result == 0 && "$add_to_steam_file" == *.desktop ]]
                then
                    # "application/x-desktop"
                    add_to_steam "$add_to_steam_file"
                else
                    # "application/x-executable"
                    # "application/vnd.appimage"
                    # "application/x-shellscript"
                    # "application/x-ms-dos-executable"
                    create_desktop_file "$add_to_steam_file"
                    add_to_steam "$desktop_file"
                fi
                ;;
         1)
                zenity --info --text="No file selected.";;
        -1)
                zenity --warning --text="An unexpected error has occurred.";;
esac



