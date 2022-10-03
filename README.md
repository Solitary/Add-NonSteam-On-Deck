# Add-NonSteam-On-Deck
GUI script allowing adding non-Steam apps while in gaming mode on Steam Deck. No need to switch to desktop mode anymore, no need to restart!

Main focus is on installed apps (Flatpaks) and other system applications, with easy way to look for shell scripts, executables (including Windows *.exe files).
Do not forget to enable comptability layer for given app when adding *.exe files. 

Script creates temporary directory to present all installed flatpaks and system apps in one place. This directory is refreshed everytime this script is run.

![Add to Steam GUI](/add-to-steam-gui.jpg?raw=true "Add to Steam while in Gaming mode")

## Simple HOWTO install and use

 1. Download the script [add-to-steam-gui.sh](add-to-steam-gui.sh) from this repository and put it on your Steam Deck. 
     - Directory `/home/deck/bin` is a good place where user should place own executables or scripts. 
     - Create `/bin` directory in your `/home/deck` folder if necessary and put the script in there. 
  
 2. Set the script to be executable.
     - Run command `chmod +x /home/deck/bin/add-to-steam-gui.sh`
     - Enabling executable bit via right-click on the file in Dolphin file explorer and going to Properties > Permissions.
 
 3. Add the script as non-Steam app in desktop mode Steam client. This will be the last time you will need to do it in desktop mode :)
     - After you sucessfully add it, you might want to change the Steam label of this app to something more clear, because by default Steam will give it the name of the file.

 4. Boot back into gaming mode and run the app. 
     - You should now see file selection dialog that by default starts in directory `/tmp/.installed_apps`. This is temporary directory that the script freshly creates and re-populates everytime it's started, with names of all installed flatpak apps and system tools to make it easier to browse and select these applications.
     - If you want to add anything else (like your own shell script, executable, even windows executable), just browse your filesystem and find the file in question. 
     - ***Remember that after adding \*.exe file you will still need to manually set compatibility layer (Proton) for it.***
 
 5. Extra step) To be able to fully utilize gaming mode and also install apps from there, you might want to add Discover as another non-Steam app. You can now do that easily with this script too.
     - Discover should be working fine, just select appropriate controller layout. `Web browser layout` is decent choice as it gives you mouse and mouse scrolling functionality on trackpads to browse through apps comfortably.
     - You will need to quit Discover by selecting **Exit game** when you are done. 
