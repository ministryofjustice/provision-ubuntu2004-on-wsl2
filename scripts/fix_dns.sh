#!/bin/bash


defaultnameserver_ip="192.168.1.1"
default_hostname=$(grep -E '^PRETTY_NAME=' /etc/os-release | cut -d'=' -f2 | sed "s/ /-/g;s/\./-/g;s/\"//g")

while getopts n:h: flag
do
    case "${flag}" in
        n) nameserver="${OPTARG}";;
        h) hostname="${OPTARG}";;
    esac
done

[[ -z ${nameserver} ]] && nameserver="${defaultnameserver_ip}"
[[ -z ${hostname} ]] && hostname="${default_hostname}"


current_hostname="$(hostname)"
current_time=$(date "+%Y_%m_%d-%H_%M_%S")
setup_backup_dir="${HOME}/setup-backup/${current_time}"

printf "Nameserver ip - %s\n" "${nameserver}"
printf "Current Hostname - %s\nNew Hostname - %s\n\n" "${current_hostname}" "${hostname}"

read -n 1 -r -s -p $'Press enter to continue...\n'

mkdir -p "${setup_backup_dir}"

sudo cp /etc/hosts ${setup_backup_dir}/hosts
sudo cp /etc/hostname ${setup_backup_dir}/hostname
sudo cp /etc/resolv.conf ${setup_backup_dir}/resolv.conf

cat << EOF > ./wsl2/wsl.conf
[network]
generateHosts = false
generateResolvConf = false
hostname = ${hostname}
EOF

echo "nameserver ${nameserver}" > wsl2/resolv.conf
echo "${hostname}" > wsl2/hostname

cat wsl2/resolv.conf
cat wsl2/wsl.conf
sudo sed -i "s/${current_hostname}/${hostname}/g" /etc/hosts

cat /etc/hosts

sudo cp wsl2/wsl.conf /etc/wsl.conf
sudo rm -f /etc/resolv.conf
sudo cp wsl2/resolv.conf /etc/resolv.conf
sudo cp wsl2/hostname /etc/hostname
echo "Open a powershell terminal and run 'wsl --shutdown'"
read -n 1 -r -s -p $'Press enter to continue...\n'
