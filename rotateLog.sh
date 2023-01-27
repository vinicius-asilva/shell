#!/bin/bash

DIR_BACKUPS="/home/backups/nginx" # Diretório do backup
FILES_DIR=5 # Quantidade de arquivos que vão permanecer no diretorio
LOG="/var/log/rotateBkp"
DATE=$(date +'%d-%m-%y as %H:%M')

for file in $(ls -t $DIR_BACKUPS | sed '1,'$FILES_DIR'd')
do
    rm -f $file
    echo "Arquivo $file removido - $DATE" | tee -a $LOG
done
