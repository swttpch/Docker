#!/bin/bash
caminho=$(find . -name "repositorio-ec2-pi")
usuario=$(whoami)

echo "procurando o zip"
which zip
if [ $? = 0 ]
then echo “Já possui zip”
else echo “Instalando zip”
sudo apt install zip
echo "adicionando o caminho sdk ao curl"
curl -s "https://get.sdkman.io" | bash
fi
echo "reiniciar o terminal"
source "/home/$usuario/.sdkman/bin/sdkman-init.sh"
echo "buscado para ver se tem java"
which java
if [ $? = 0 ]
then echo “Já possui java”
else echo “Instalando java”
sdk install java 11.0.12.7.1-amzn 
fi

echo "versão do java"
java -version

echo "atualizando os pacotes"
sudo apt update && sudo apt upgrade

echo "procurando o docker"
which docker
if [ $? = 0 ]
then echo “Já possui docker”
else echo “Instalando docker”
sudo apt install docker.io
fi

echo "iniciando o docker"
sudo systemctl start docker

echo "definindo para o serviço do docker sempre iniciar"
sudo systemctl enable docker

echo "baixando a imagem do mysql"
sudo docker pull mysql:5.7

echo "criando uma imagem customizada do mysql com o banco de dados"
sudo docker build -t monitech_img:1.0 .


echo "executando o container com mysql"
sudo docker run -d -p 3306:3306 --name MonitechBD monitech_img:1.0

echo "mostrando o status do container"
sudo docker stats MonitechBD

echo "instalação completa"



