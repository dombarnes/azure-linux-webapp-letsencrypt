#!/bin/bash
DATE=$(date +%Y-%m-%d)
CERT_PW='somepassword'
DOMAIN=mydomain.com
RG=my-azure-rg
PFX="$DOMAIN-$DATE.pfx"
APP_SERVICE=my-azure-webapp
echo "-- Renewing SSL with Let's Encrypt"
sudo certbot certonly -n -d $DOMAIN --manual --manual-public-ip-logging-ok --manual-auth-hook ./azure_certbot_auth.sh --manual-cleanup-hook ./azure_certbot_cleanup.sh
echo "-- PFX Filename:" $PFX
echo "-- Converting to PFX with openssl"
sudo openssl pkcs12 -export -out ./SSL/$PFX -inkey /etc/letsencrypt/live/$DOMAIN/privkey.pem -in /etc/letsencrypt/live/$DOMAIN/fullchain.pem -password pass:$CERT_PW
sudo chown $(whoami):staff ./$PFX
echo "-- Uploading SSL"
AZ_RESULT=$(az webapp config ssl upload --certificate-file ./$PFX --name $APP_SERVICE --resource-group $RG --certificate-password $CERT_PW --output tsv --query thumbprint)
echo "-- Thumbprint is $AZ_RESULT"
echo "-- Binding SSL"
az webapp config ssl bind --certificate-thumbprint $AZ_RESULT --ssl-type SNI --name $APP_SERVICE --resource-group $RG
echo "-- Cleaning up PFX"
rm ./SSL/$PFX
echo "-- Cleaning up verification"
rm $CERTBOT_TOKEN
echo "-- Complete"
