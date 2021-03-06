#!/bin/sh
#Instructions to use this script
#
#chmod +x SCRIPTNAME.sh
#
#sudo ./SCRIPTNAME.sh
echo "###################################################################################"
echo "Please be Patient: Installation will start now.......and it will take some time :)"
echo "###################################################################################"
#Update the repositories
sudo apt-get update
#Apache, Php, MySQL and required packages installation
sudo apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-cli php5-dev mysql-client
php5enmod mcrypt
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
apt-get install pwgen -y
MYSQL_ROOT_PASS="MYPASSWORD123" # Put yours
PHPMYADMIN_DIR="pmasecret879"      # You don't want script kiddies playing  
                                   # with your default phpMyAdmin install.
AUTOGENERATED_PASS=`pwgen -c -1 20`
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $AUTOGENERATED_PASS" |debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $AUTOGENERATED_PASS" | debconf-set-selections
apt-get -y install phpmyadmin
# Regex FTW!
sed -i -r "s:(Alias /).*(/usr/share/phpmyadmin):\1$PHPMYADMIN_DIR \2:" /etc/phpmyadmin/apache.conf
php5enmod mcrypt # Needs to be activated manually (that's an issue for Ubuntu 14.04)
service apache2 reload
sudo apt-get -y install php5
sudo apt-get -y install php5-curl
cd /var
cd www
cd html
#Setting up ZnoteAAC
git clone https://github.com/Znote/ZnoteAAC.git
cd ZnoteAAC
#Moving ZnoteAAC to html
mv * ../
cd /var/www/html ZnoteAAC 
rm index.html
sudo /etc/init.d/apache2 restart
#Grabbing pre-compiled TFS 1.20
cd
wget http://109.235.71.13/forgottenserver.rar
tar -xvf forgottenserver.tar
cd
cd forgottenserver
cat Readme.txt
