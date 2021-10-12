#!/bin/bash
#Funciones para llevar acabo el backup de los archivos de la carpeta /home/user/Escritorio/Seguridad#

#Previamente se crea una carpeta general (SGSSI) donde se guardaran los backups en la direccion /var/tmp/Backups/#
#Dentro de la carpeta crearemos dos carpetas
#--> una para el backup de los archivos de Seguridad (Sec)
#--> otra para backup de la BD de MySQL (BD)
fecha=`date +%d-%m-%y`
fechaAnt=`date -d yesterday +%d-%m-%y`
cd /var/tmp/Backups/SGSSI/Sec
mkdir $fecha
cd /home/usuario/Escritorio/Seguridad
vacio= $(ls /var/tmp/Backups/SGSSI/Sec/$fechaAnt | grep “$fechaAnt”)
if [ -z $vacio ] then
	rsync -av /home/usuario/Seguridad/ /var/tmp/Backups/SGSSI/Sec/$fecha
else
rsync -av --link-dest=/var/tmp/Backups/SGSSI/Sec/$fechaAnt . /var/tmp/Backups/SGSSI/Sec/$fecha
fi
cd /var/tmp/Backups/SGSSI/BD
mkdir $fecha
mysqldump -u 'usuario' -p '1384001u.D' 'SGSSI' > /var/tmp/Backups/SGSSI/BD/$fecha/backup_SGSSI.sql #crear backup
#              username        db_name
# para recuperarlo seria mysql -u ‘username’ -p ‘database_name’ < [backup_name].sql

#Se ejecuta en la consola el siguiente comando :$ crontab -e
#para hacerlo cada dia a las 12 del mediodia: 0 12 * * * /home/usuario/script_folder/backup.sh
#*****:
#minute hour daymonth(1-31) month dayweek(0-6)
