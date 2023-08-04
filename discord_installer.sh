#!/bin/bash

function remove_discord {
    # Check if Discord is installed
    if dpkg -l | grep -q discord; then
        echo "Removing discord..."
        sudo dpkg -r discord
        echo "Discord removed successfully."
    else
        echo "Discord is not installed."
    fi
}

function install_discord {
    # Check if Discord is installed
    if dpkg -l | grep -q discord; then
        echo "Discord is already installed."
    else
        echo -n "Discord is getting installed..."
        echo -ne "\r(--------------------)   [0%]"
        sudo mkdir -p /tmp/installer
        echo -ne "\r(######--------------)   [25%]"
        sudo wget -q "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
        echo -ne "\r(##########----------)   [50%]"
        sudo mv discord.deb /tmp/installer/discord.deb
        echo -ne "\r(##############------)   [75%]"
        sudo dpkg -i /tmp/installer/discord.deb &>/dev/null
        echo -ne "\r(####################)   [100%]"
        echo -e "\nDiscord was installed."
    fi
}

# Hauptprogramm
if [ $# -eq 0 ]; then
    echo "Please use --install or --remove to install or remove Discord."
else
    case $1 in
        --install)
            install_discord
            ;;
        --remove)
            remove_discord
            ;;
        *)
            echo "Unknown command, please use --install or --remove to install or remove Discord."
            ;;
    esac
fi
