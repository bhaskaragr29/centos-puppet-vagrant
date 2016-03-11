class php{

   package { [
    "php56w",
    "php56w-opcache",
    "php56w-xml",
    "php56w-mcrypt",
    "php56w-gd",
    "php56w-devel",
    "php56w-mysql",
    "php56w-intl",
    "php56w-mbstring",
    "php56w-bcmath"]:
     ensure => installed;
  }


  file{ '/etc/php.ini':
    require => [Package['httpd'],Package['php56w']],
    source  => "puppet:///modules/php/php.ini",
    owner   => 'root',
    mode    => 0644,
    notify  =>  Service['httpd']
  }
}

class phpunit{
  exec{ 'phpunit':
    command => "wget https://phar.phpunit.de/phpunit.phar -O phpunit.phar; chmod +x phpunit.phar; mv phpunit.phar /usr/local/bin/phpunit",
    path => "/usr/local/bin:/bin:/usr/bin",
    onlyif  => "/usr/bin/test ! -d /usr/local/bin/phpunit",
    require => File['/etc/php.ini']
  }
}