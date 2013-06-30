name             "freistilbox-solo"
maintainer       "freistil IT"
maintainer_email "cookbooks@freistil.it"
license          "Apache 2.0"
description      "Installs/Configures freistilbox-solo"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

depends "apache2"
depends "apt"
depends "build-essential"
depends "database"
depends "mysql"
depends "nginx"
depends "php"
depends "varnish"


