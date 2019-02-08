#!/bin/bash
DATE=$(date +%Y-%m-%d)
CERT_PW='somepassword'
PFX="mydomain-$DATE.pfx"
sudo certbot certonly -d $CERT_DOMAIN --manual --manual-public-ip-logging-ok --manual-auth-hook ./azure_certbot.sh --manual-cleanup-hook ./azure_certbot_cleanup.sh
echo $PFX
sudo openssl pkcs12 -export -out $PFX -inkey /etc/letsencrypt/live/$CERT_DOMAIN/privkey.pem -in /etc/letsencrypt/live/$CERT_DOMAIN/fullchain.pem -password pass:$CERT_PW
AZ_RESULT=$(az webapp config ssl upload --certificate-file $PFX --name my-webapp --resource-group my-resource-group --certificate-password $CERT_PW)
THUMBNAIL=$(ruby -e 'require "json";r = JSON.parse(ARGV[0]);puts r["thumbprint"]' "$AZ_RESULT")
az webapp config ssl bind --certificate-thumbprint $THUMBNAIL --ssl-type SNI --name my-webapp --resource-group my-resource-group
