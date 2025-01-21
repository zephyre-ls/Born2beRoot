#!/bin/bash

#Script en bash permettant l'affichage de diverses info systeme. 
#Se lance au lancement du serveur puis toutes les 10 mins sur les terminaux

#####################################################################
################# - FONCTIONS
#RAM
memory_info=$(free | grep Mem)
total_memory=$(echo $memory_info | awk '{print$2}')
used_memory=$(echo $memory_info | awk '{print$3}')
available_memory=$((total_memory - used_memory))
memory_usage=$((used_memory * 100 / total_memory))
#DISK
disk_info=$(df -h --total | grep 'total')
total_disk=$(echo &disk_info | awk '{print$2}')
used_disk=$(echo &disk_info | awk '{print$3}')
available_disk=$(echo &disk_info | awk '{print$4}')
pourcentage=$(echo &disk_info | awk '{print$5}')
#CPU
cpu_usage=$(top -bn1 | grep"Cpu(s)" | awk '{print $2 + $4')
###############################################################

#Script à envoyer
message="
================================================================

                  INFORMATIONS DU SYSTEME
                  $(date +"%d-%m-Y %H:%M:%S")
        
===============================================================

# Architecture     : $(uname -m)
# Kernel           : $(uname -r)
# OS               : $(uname -o)
# CPU physical     : $(grep "physical id" /proc/cpuinfo |wc -l)
# CPU virtual      : $(grep "processor" /proc/cpuinfo | wc -l)
# Memory Usage/RAM : ${used_memory}/${total_memory} MB (${memory-usage}%)
# Disk Usage       : ${used_disk}/${total_disk} (${pourcentage})
# CPU load         : ${cpu_usage}%
# Last boot        : $(who -b | awk '$1 == "system" {print $3 " " $4}')
# LVM use          : $(lvscan | grep -q "ACTIVE" && echo "Actif" || echo "Innactif")
# Connexions TCP   : $(ss -t | grep -c ESTAB)
# User log         : $(user | wc -w)
# IPV4             : $(hostname -I)
# MAC              : $(ip link show | grep "link/ether" | awk '{print $2}')
# Sudo             : $(journalctl _COMM=sudo | grep COMMAND | wc -l)
"

# Vérifie si VIM est en route, si actif pas de script. (Parce que c'est relou)
if pgrep -x "vim" > /dev/null; then
    echo "Vim est actif, script reporté à la prochaine exécution."
    exit 0
fi

#Utilisation de la fonction wall pour envoyer le message 
wall"$message"
