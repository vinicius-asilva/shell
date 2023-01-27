#!/bin/bash

APP_NAME="nginx"
LOG="/var/log/installPkg"
DATE=$(date +'%d-%m-%y')

pkgInstall () {
  
    if [[ -n $(yum list installed | grep $APP_NAME) ]]
    then
        echo "Pacote $APP_NAME ja instalado no servidor" | tee -a $LOG
    else
        echo "Pkg $APP_NAME nao instalado, iniciando instalação $(yum install nginx -y)" | tee -a $LOG
        if [[ $? == 0 ]]
        then
            echo "Instalação $APP_NAME finalizada com sucesso - $DATE" | tee -a $LOG
        else
            echo "Falha instalação $APP_NAME verificar log - $DATE" | tee -a $LOG
    fi
fi
}

epelInstall () {
    yum install epel-release -y
}

epelInstall # Função para instalação/update de repositorio para download nginx
pkgInstall

