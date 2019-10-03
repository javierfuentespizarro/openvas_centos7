#!/bin/bash
echo "Instalación automatizada de Openvas en Centos 7" 
echo "-----------------------------------------------"
echo "Desactivando SELINUX"
sed -i 's/=enforcing/=disabled/' /etc/selinux/config
echo "Abriendo puertos necesarios en el firewall"
firewall-cmd --zone=public --add-port=9392/tcp --permanent
echo "Reload del Firewall"
firewall-cmd --reload
echo "Actualización e instalación de paquetes genericos"
yum -y update
yum -y install wget net-tools
wget -q -O - https://updates.atomicorp.com/installers/atomic | sh
echo "-----------------------------------------------"
echo "Instalación OpenVas - GVM"
yum -y install greenbone-vulnerability-manager
echo "-----------------------------------------------"
echo "Descomentando # unixsocket /tmp/redis.sock  y # unixsocketperm 700"
sed -i '/^#.*unixsocket/s/^# //' /etc/redis.conf
echo "Reiniciamos y habilitamos el servicio de redis"
systemctl enable redis && systemctl restart redis
echo "Iniciando configuración + descarga Openvas"
echo "Escoge RSYNC como predeterminado!"
echo "Recuerda que deberas crear una contraseña de administración para el usuario admin"
openvas-setup
echo 'OPTIONS="--listen=0.0.0.0 --port=9392"' > /etc/sysconfig/gsad
systemctl start gsad
echo "Accede a Openvas a traves de tu IP con el puerto 9392"


