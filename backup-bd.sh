#!/bin/bash

DIR_BKP_DB="/home/backups/DB"
DIR_BKP_NGINX="/home/backups/nginx"
DATABASE_LIST=$(ls -d /var/lib/mysql/*/ | cut -d "/" -f5 | grep -v performance_schema | grep -v test) # Caso tenha algum banco que não precise realizar o backup adicionar nessa linha com o | grep -v nome
USER_DB="backup"
PASS_DB="P@ssw0rd1020@@"
DIR_NGINX="/etc/nginx"
LOG_FILE="/var/log/backups.log"
DATE=$(date +'%d/%m/%Y as %H:%M')
DATE_BKP=$(date +'%d%m%y')

verifyDir () {
    [[ -d $DIR_BKP_DB ]] && echo "Realizar backup DB" || echo "Diretório de backup não existe, esta sendo criado automaticamente $(sudo mkdir -p $DIR_BKP_DB)"
    [[ -d $DIR_BKP_NGINX ]] && echo "Realizar backup Nginx" || echo "Diretório de backup não existe, esta sendo criado automaticamente $(sudo mkdir -p $DIR_BKP_NGINX)"
}


backupDB () {

 	echo -e "\nInicio geração backup banco de dados MySql $DATE\n" | tee -a $LOG_FILE
	for databaseName in $DATABASE_LIST
	do
	echo "Gerando backup da base de dados $databaseName - $DATE" | tee -a $LOG_FILE 
    mysqldump -u $USER_DB -p$PASS_DB $databaseName > $DIR_BKP_DB/"$databaseName"_$DATE_BKP.sql 
	[[ $? == 0 ]] && echo -e "\tBackup Concluido base de dados $databaseName - $DATE" | tee -a $LOG_FILE || echo -e "\t\t!!! FALHA GERAÇÃO BACKUP MYSQL - $DATE" | tee -a $LOG_FILE
	done

}

backupNginx () {

	echo -e "\nInicio backup Nginx - $DATE" | tee -a $LOG_FILE
    cd $DIR_BKP_NGINX && tar -czpf nginx-$DATE_BKP.tar.gz $DIR_NGINX
    [[ $? == 0 ]] && echo -e "\tBackup Concluido Nginx - $DATE" | tee -a $LOG_FILE || echo -e "\t\t!!! FALHA GERAÇÃO BACKUP NGINX - $DATE" | tee -a $LOG_FILE

}

verifyDir
backupDB
backupNginx