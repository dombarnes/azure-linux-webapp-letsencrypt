# Azure Linux Web App SSL Renewal with Let's Encrypt

This is a collection of scripts I wrote to semi-automate the process of manually renewing, uploading and binding an SSL certificate from Let's Encrypt to Azure's Linux Web App hosting. I built it for use with my Sinatra-based webapp. Its designed to be run on a local machine, not on the web app.

## Requirements
You can install most of these from [Homebrew](https://brew.sh)  
- certbot  
- openssl  
- lftp  
- Azure CLI  

So why not try :
```brew install openssl certbot lfpt azure-cli```


## Use
Simply edit the three files with your relevant web app name, resource group from Azure, deployment credentials (get these from the Publish Profile) and run  
```./rewew_ssl.sh```
