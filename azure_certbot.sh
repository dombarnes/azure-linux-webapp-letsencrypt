#!/bin/bash
USER='app-name\$deploy-user'
PASSWD='deploy-password'
HOST=some-string.ftp.azurewebsites.windows.net
echo "Validation file is $CERTBOT_TOKEN"
echo "Making Validation File..."
echo $CERTBOT_VALIDATION > $CERTBOT_TOKEN
echo "Uploading validation file"
lftp  -u $USER,$PASSWD $HOST <<EOT
mkdir /site/wwwroot/public/.well-known/acme-challenge
cd /site/wwwroot/public/.well-known/acme-challenge
put $CERTBOT_TOKEN
quit
EOT
echo 'Validation uploaded'
exit 0
