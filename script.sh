#!/bin/bash
echo "Deseja instalar a interface gráfica? (s/n)"
read inst
if [ \"$inst\" == \"s\" ];
then
		sudo apt-get install xrdp lxde-core lxde tigervnc-standalone-server -y
else
		echo "Atualizando Pacotes"
fi

sudo apt update && sudo apt upgrade -y
java --version
if [ $? -eq 0 ];
then
	echo "Java já está instalado"
else
	echo "Gostaria de instalar o Java? (s/n)"
	read inst
	if [ \"$inst\" == \"s\" ];
	then
		sudo apt install default-jre -y
	fi
fi

docker --version
if [ $? -eq 0 ];
then
	echo "Docker já está instalado"
else
	echo "Gostaria de instalar o Docker e Banco TotomSystem? (s/n)"
	read inst
	if [ \"$inst\" == \"s\" ];
	then
		sudo apt install docker.io -y

		echo "Iniciando Docker"
		echo "Caminho: "
		pwd
		sudo systemctl start docker
		sudo systemctl enable docker
		cd /home/$USER/Script-VM/docker-mysql
		sudo docker-compose up -d
		sudo docker start CONTAINER_TOTEMDB
		sudo docker exec -it $(sudo docker ps -aqf "name=containerDB") mysql -u root -p -B -N -e "
		create database totembd;

		use totembd;

		create table endereco (
		    idEndereco int primary key auto_increment,
		    cep char(8) not null,
		    numero int not null
		);

		create table estacao(
			idEstacao int primary key auto_increment,
		    fkEndereco int,
			nomeEstacao varchar(45),
		    foreign key (fkEndereco) references endereco(idEndereco)
		);

		create table empresa(
		    idEmpresa int primary key auto_increment,
		    fkEstacao int,
		    nomeEmpresa varchar(45),
		    cnpj char(14),
		    foreign key (fkEstacao) references estacao(idEstacao)
		);

		create table usuario(
		    idUsuario int auto_increment,
		    fkEmpresa int,
		    primary key (idUsuario, fkEmpresa),
		    nomeUsuario varchar(45),
		    email varchar(60),
		    senha varchar(50),
		    tipoUsuario int,
		    foreign key (fkEmpresa) references empresa(idEmpresa)
		);

		create table totem (
		    idTotem int primary key auto_increment,
		    fkEstacao int,
		    marca varchar (45),
		    so varchar (45),
		    foreign key (fkEstacao) references estacao(idEstacao)
		);

		create table disco (
		    idDisco int auto_increment,
		    fkTotem int,
		    primary key (idDisco, fkTotem),
		    nome varchar (45),
		    modelo varchar (45),
		    volumeTotal double,
		    foreign key (fkTotem) references totem(idTotem)
		);

		create table memoria (
		    idMemoria int primary key auto_increment,
		    fkTotem int,
		    memoriaTotal double,
		    foreign key (fkTotem) references totem(idTotem)
		);

		create table processador (
		    idProcessador int primary key auto_increment,
		    fkTotem int,
		    fabricante varchar (45),
		    nome varchar (10),
		    microArq varchar (10),
		    frequencia double,
		    foreign key (fkTotem) references totem(idTotem)
		);

		create table processo (
		    idProcesso int primary key auto_increment,
		    fkTotem int,
		    nome varchar(45),
		    foreign key (fkTotem) references totem(idTotem)
		);

		create table dado (
		    idDado int auto_increment,
		    fkTotem int,
		    primary key (idDado, fkTotem),
		    memoriaUso double,
		    memoriaDisponivel double,
		    volumeUso double,
		    volumeDisponivel double,
		    memoriaUsoProcesso double,
		    processadorUsoProcesso double,
		    foreign key (fkTotem) references totem(idTotem)
		);"

		echo Banco de dados Criado com Sucesso!
	fi
fi

cd ~/Desktop
git clone https://github.com/Grupo8-2ADSB-TotemSystem/Java_Totem_System.git
cd Java_Totem_System/Totem_System/target
java -jar Totem_System-1.0-SNAPSHOT-jar-with-dependencies.jar
