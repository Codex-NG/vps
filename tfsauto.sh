#!/bin/bash
apt-get update
apt-get install luajit
apt-get install sudo
sudo apt-get install git cmake build-essential liblua5.2-dev libgmp3-dev libmysqlclient-dev libboost-system-dev
apt-get upgrade
git clone https://github.com/otland/forgottenserver.git
cd forgottenserver
mkdir build && cd build
cmake ..
make
mv tfs ..
echo "###################################################################################"
echo "Please be Patient: Installation will start now.......and it will take some time :)"
echo "###################################################################################"
#Update the repositories
sudo apt-get update
#Apache, Php, MySQL and required packages installation
sudo apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-mysqlnd php5-gd php5-cli php5-dev php5-json mysql-client
php5enmod mcrypt
sudo apt-get upgrade
#The following commands set the MySQL root password to MYPASSWORD123 when you install the mysql-server package.
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password MYPASSWORD123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MYPASSWORD123'
sudo apt-get -y install mysql-server
#Restart all the installed services to verify that everything is installed properly
echo -e "\n"
service apache2 restart && service mysql restart > /dev/null
echo -e "\n"
if [ $? -ne 0 ]; then
echo "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
echo "Installed Services run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"
fi
echo -e "\n"
git clone https://github.com/DevelopersPL/DevAAC.git
mv  -v ~/DevAAC/* ~/var/www/
mv -v ~/DevAAC/public_html/* ~/var/www/html
