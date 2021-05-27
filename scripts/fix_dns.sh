#!/bin/bash

sudo cp wsl2/wsl.conf /etc/wsl.config
sudo rm -f /etc/resolv.conf
echo "nameserver $1" >> wsl2/resolv.conf
sudo cp wsl2/resolv.conf /etc/resolv.conf
echo "Open a powershell terminal and run 'wsl --shutdown'"
read -n 1 -r -s -p $'Press enter to continue...\n'