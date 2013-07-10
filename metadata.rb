name             'dvwa'
maintainer       'Rapid7'
maintainer_email 'erran_carey@rapid7.com'
license          'Copyright (c) 2012-2013, Rapid7. All Rights Reserved.'
description      'Recipes to install DVWA and run a web server using XAMPP'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends          'apt'
depends          'apache2'
depends          'php'
depends          'mysql'
depends          'xampp'
