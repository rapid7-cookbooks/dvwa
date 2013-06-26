# Damn Vulnerable Web Application
## Description
Installs Damn Vulnerable Web Application to a XAMPP installation (recommended by the DVWA documentation).

## Cookbooks
* apache2
* mysql
* xampp

## Requirements
### Platform
* Debian (Untested)
* Ubuntu (Tested on 12.04)

## Attributes
* Includes attributes from [xampp::default](). ***FIXME***
* node[:dvwa][:dir] Where to install DVWA, defaults to /opt/lampp/htdocs
* node[:dvwa][:flavor] The type of install to use, defaults to :xampp, alternatively use :apache2
* node[:dvwa][:url] From where to install DVWA, defaults to http://downloads.sourceforge.net/project/dvwa/DVWA-1.0.7.zip
* node[:dvwa][:version] What version of DVWA to install, defaults to 1.0.7
* node[:dvwa][:zip_name] The name of the archive to install from, DVWA-1.0.7.zip

## Usage
### dvwa::default
Includes the dvwa::server recipe.

### dvwa::server
Installs DVWA on a web server. Select the install method by setting node[:dvwa][:flavor] to :xampp (default) or :standalone.

### dvwa::xampp
Includes the XAMPP recipe and unarchives DVWA inside of /opt/lampp/htdocs.

### dvwa::standalone
Downloads packages used by DVWA and includes the apache2 and mysql recipes to run a web server.

## License and Author
### Authors
* Erran Carey (erran_carey@rapid7.com)
