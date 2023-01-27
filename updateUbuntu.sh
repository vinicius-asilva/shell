#!/bin/bash

LOG="/var/log/updateUbuntu.log"
DATE=$(date +'%d-%m-%y as %H:%M')

echo -e "\n\n Atualização de pacotes do Ubuntu - $DATE" | tee -a $LOG
apt update -y 2> $LOG
[[ $? == 0 ]]
then
    echo "Comando para atualizar executado com sucesso - $DATE" | tee -a $LOG
else    
    echo -e "Falha na execução do comando verificar log - $DATE\n\n" | tee -a $LOG
fi