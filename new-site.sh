#!/bin/bash

# This var must be set or the script will exit
# Ex: "/Users/you/www" - no trailing slash
BASE_DOCROOT=""

if [ -z $BASE_DOCROOT ]; then echo "You must fill out the BASE_DOCROOT variable to run this script."; exit 1; fi

SITE=$1
SITEPATH=$2
if [ -z $1 ]; then
	read -p "New local site name: " SITE
	if [ -z $SITE ]; then echo "Exiting with no action"; exit 0; fi
fi
if [ -z $2 ]; then
	read -p "Site path [${BASE_DOCROOT}]...: " SITEPATH
	if [ -z $SITEPATH ]; then echo "Exiting with no action"; exit 0; fi
fi

#/etc/hosts
cp /etc/hosts /etc/hosts.bak
echo -e "127.0.0.1\t${SITE}.local" >> /etc/hosts

#httpd-vhosts.conf
VHOSTSFILE="/etc/apache2/extra/httpd-vhosts.conf"
cp $VHOSTSFILE ${VHOSTSFILE}.bak
echo "<VirtualHost *:80>" >> $VHOSTSFILE
echo -e "\tDocumentRoot \"${BASE_DOCROOT}/${SITEPATH}\"" >> $VHOSTSFILE
echo -e "\tServerName ${SITE}.local" >> $VHOSTSFILE
echo -e "\tServerAlias ${SITE}.localhost" >> $VHOSTSFILE
echo -e "\tErrorLog \"/private/var/log/apache2/${SITE}.local-error_log\"" >> $VHOSTSFILE
echo -e "\tCustomLog \"/private/var/log/apache2/${SITE}.local-access_log\" common" >> $VHOSTSFILE
echo '</VirtualHost>' >> $VHOSTSFILE

#restart apache
apachectl restart

echo "Apache restarting"