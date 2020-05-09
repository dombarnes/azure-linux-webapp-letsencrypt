# Azure Linux Web App SSL Renewal with Let's Encrypt

This is a collection of scripts I wrote to semi-automate the process of manually renewing, uploading and binding an SSL certificate from Let's Encrypt to Azure's Linux Web App hosting. I built it for use with my Sinatra-based webapp. Its designed to be run on a local machine, not on the web app.  

It will create your SSL certificate, uploading the validation code and token via FTP to your Azure Web App hosting (and remove them once complete), convert the SSl to a PFX file, upload the PFX to Azure Portal, then bind the SSL to your custom domain name.  

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


Note: These scripts are provided as is. Test them first before using in any production environment. Don't be dumb enough to run random scripts from the internet on live stuff.


## Changelog

2020-05-09 - Added Resource Group variable name, more progress output  
2020-02-08 - Added Readme  
2020-02-08 - Initial Commit
