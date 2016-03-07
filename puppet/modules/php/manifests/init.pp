class php{

   package { [
    "php56-php-5.6*",
    "php56-php-gd-5.6*",
    "php56-php-mbstring-5.6*",
    "php56-php-mysqlnd-5.6*",
    ]: ensure => installed,
    require => Yumrepo["remi-repo"],
  }

  file{ '/etc/php.ini':
    require => [Package['httpd'],Package['php56-php-5.6*']],
    source  => "puppet:///modules/php/php.ini",
    owner   => 'root',
    mode    => 0600,
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