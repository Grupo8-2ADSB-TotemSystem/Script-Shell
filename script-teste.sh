#!/bin/bash

sudo docker run -it --rm --name totem-system-java openjdk:11

cd ~/Desktop
cd Java_Totem_System/Totem_System/target
java -jar Totem_System-1.0-SNAPSHOT-jar-with-dependencies.jar
