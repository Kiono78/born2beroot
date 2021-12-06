#!bin/bash

ARCHITECTURE=$(uname -a)
CPU_PHYSICAL=$(lscpu | awk 'FNR == 9 {print $2}')
vCPU=$(lscpu | awk 'FNR == 5 {print $2}')
USED_MEM=$(free -m | awk 'FNR == 2 {print $3}')
TOTAL_MEM=$(free -m | awk 'FNR == 2 {print $2}')
FREE_MEM=$(free -m | awk 'FNR == 2 {printf("%.2f"), $3/$2 * 100.0}')

wall "
#Architecture: $ARCHITECTURE
#CPU physical: $CPU_PHYSICAL
#vCPU physical: $vCPU
#Memory Usage: $USED_MEM/${TOTAL_MEM}MB (${FREE_MEM}%)
"
