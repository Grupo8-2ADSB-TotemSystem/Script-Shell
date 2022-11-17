#!/bin/bash

#wget https://github.com/Grupo8-2ADSB-TotemSystem/Jar-TotemSystem/raw/main/Totem_System-1.0-SNAPSHOT-jar-with-dependencies.jar
#sudo docker build -t Totem_System-1.0-SNAPSHOT-jar-with-dependencies.jar.
#sudo docker run -it --rm --name totem-system-java openjdk:11
#java -jar Totem_System-1.0-SNAPSHOT-jar-with-dependencies.jar
#cd /home/$USER/Área de Trabalho/Script-Shell/docker-mysql

wget https://github.com/Grupo8-2ADSB-TotemSystem/Jar-TotemSystem/raw/main/Totem_System-1.0-SNAPSHOT-jar-with-dependencies.jar
sudo docker build -t dockerfile .
sudo docker run -it --rm --name totem-system-java dockerfile
java -jar Totem_System-1.0-SNAPSHOT.jar
