#!/bin/bash
USER='app-name\$deploy-user'
PASSWD='deploy-password'
HOST=some-string.ftp.azurewebsites.windows.net
echo "Deleting validation file"
lftp  -u $USER,$PASSWD $HOST <<EOT
  cd /site/wwwroot/public/.well-known/acme-challenge
  ls
  rm -rf /site/wwwroot/public/.well-known/acme-challenge/$CERTBOT_TOKEN
  quit
EOT
echo 'Validation deleted'
exit 0
