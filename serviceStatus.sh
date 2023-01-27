#!/bin/bash

SERVICE_NAME="postgresql"
DATE=$(date +'%d-%m-%y as %H:%M')
LOG="/var/log/statusService.log"

if [[ $(systemctl is-active $SERVICE_NAME) != active ]]
then
    echo "Serviço $SERVICE_NAME não esta em execução, tentativa de inicializar - $DATE" | tee -a $LOG
    systemctl start postgresql 
    if [[ $? == 0 ]]
    then
        echo "Serviço $SERVICE_NAME restabelecido - $DATE" | tee -a $LOG
    else
        echo "Falha ao iniciar serviço $SERVICE_NAME - $DATE" | tee -a $LOG
    fi
else
    echo "Serviço $SERVICE_NAME esta ativo - $DATE"| tee -a $LOG
fi