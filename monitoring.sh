#!bin/bash

ARCHITECTURE=$(uname -a)
CPU_PHYSICAL=$(lscpu | awk 'FNR == 9 {print $2}')
vCPU=$(lscpu | awk 'FNR == 5 {print $2}')
USED_MEM=$(free -m | awk 'FNR == 2 {print $3}')
TOTAL_MEM=$(free -m | awk 'FNR == 2 {print $2}')
FREE_MEM=$(free -m | awk 'FNR == 2 {printf("%.2f"), $3/$2 * 100.0}')
TOTAL_DISK=$(df -TBg | awk '/ext/ {fd += $5} END {print fd}')
USED_DISK=$(df -Tm | awk '/ext/ {fd += $3} END {print fd}')
USED_DISK_PERC=$(df -Tm | awk '/ext/ {fd += $4} {tt += $3} END {printf("%d", fd/tt * 100}')
CPU_USAGE=$(top -bn1 | awk 'FNR == 3 {print 100.0 - $8}')
LAST_BOOT=$(who -b | awk '{print $3" "$4}')
NB_LVM=$(lsblk | awk '{print $6}'| grep lvm | wc -l)
IS_LVM=$(if [$NB_LVM -eq 0]; then echo 'no'; else echo 'yes'; fi)
LOGGED_USER=$(who | awk '{print $1}' | uniq | wc -l)
TCP=$(netstat -nat | grep ESTABLISHED | wc -l)
NETWORK=$(hostname -I)
MAC=$(ip link show | awk '/link\/ether/ {print $2}')
SUDO_LOG=$(journalctl _COMM=sudo | grep -c COMMAND)

wall "
#Architecture: $ARCHITECTURE
#CPU physical: $CPU_PHYSICAL
#vCPU physical: $vCPU
#Memory Usage: $USED_MEM/${TOTAL_MEM}MB (${FREE_MEM}%)
#Disk Usage: $USED_DISK/${TOTAL_DISK}Gb (${USED_DISK_PERC}%)
#CPU load: ${CPU_USAGE}%
#Last boot: $LAST_BOOT
#LVM use: $IS_LVM
#Connexions TCP : $TCP ESTABLISHED
#User log: $LOGGED_USER
#Network: IP $NETWORK (${MAC})
#Sudo : $SUDO_LOG cmd
"
