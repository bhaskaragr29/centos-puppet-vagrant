class mysql{
  #    package{
  #      'mysql-server':
  #      ensure    => installed,
  #      require   => Yumrepo["remi-repo"],
  #    }

  package { "mysql-server": ensure => installed }
  package { "mysql": ensure => installed }
    service { "mysqld":
      enable => true,
      ensure => running,
      require => Package["mysql-server"],
  }

file { "/var/lib/mysql/my.cnf":
  owner => "mysql", group => "mysql",
  source => "puppet:///mysql/my.cnf",
  notify => Service["mysqld"],
  require => Package["mysql-server"],
}

file { "/etc/my.cnf":
  require => File["/var/lib/mysql/my.cnf"],
  ensure => "/var/lib/mysql/my.cnf",
}

exec { "set-mysql-password":
  unless => "mysqladmin -uroot -p$mysql_password status",
  path => ["/bin", "/usr/bin"],
  command => "mysqladmin -uroot password $mysql_password",
  require => Service["mysqld"],
}
#    file{ '/etc/my.cnf':
#      ensure	  => file,
#      source 	  => "puppet:///modules/mysql/my.cnf",
#      owner		  => 'root',
#      mode        =>  0644,
#      require     => Package['mysql-server']
#    }

#    file { "/etc/my.cnf":
#      ensure  => "link",
#      target  => "/vagrant/puppet/modules/mysql/files/my.cnf",
#      force   => true,
#      notify  => Service["mysqld"],
#      require => Package["mysql-server"],
#    }

#    file{ "/etc/my.cnf":
#      path	=> "/etc/my.cnf",
#      require => Package['mysql-server'],
#      source => "/vagrant/puppet/modules/mysql/files/my.conf",
#      owner	=> 'root',
#      mode	=> 0644,
#      notify =>  Service['mysqld'],
#    }

#    service { "mysqld":
#      ensure  => "running",
#      enable  => true,
##      require => [
##        File["/etc/my.cnf"],
##      ],
#   }

#    exec{'mysql-root-passowrd':
#      unless => 'mysqladmin -uroot -proot status',
#      command => "mysqladmin -uroot password root",
#      path    => ['/bin', '/usr/bin'],
#      require => Service['mysqld'];
#    }
}
#class mysql{
#
#
#	package{ ['mysql-server']:
#                require => [Service['cntlm'],Exec['apt-update']],
#                ensure => present,
#        }
#
#	service { 'mysql':
#    	ensure => running,
#  		require => Package['mysql-server'],
# 	}
#
#	file{ '/etc/mysql':
#	  ensure	=> directory,
#	  before	=> File['/etc/mysql/my.cnf'],
#	}
#
#	file{ '/etc/mysql/my.cnf':
#          ensure	  => file,
#          require 	=> Package['mysql-server'],
#	  	    notify 	  => Service['mysql'],
#          source 	  => 'puppet:///modules/mysql/my.cnf',
#          owner		  => 'root',
#          mode      =>  0644
#	}
#
#	exec{'mysql-root-passowrd':
#		unless => 'mysqladmin -uroot -proot status',
#		command => "mysqladmin -uroot password root",
#    	path    => ['/bin', '/usr/bin'],
#    	require => Service['mysql'];
#	}
#
#	exec { "Create-drupal-db":
#    command => "mysql -proot -e \"CREATE DATABASE IF NOT EXISTS sportsbook_ipad\";\
#                mysql -proot -e \"CREATE DATABASE IF NOT EXISTS sportsbook_ipad_qa02\";\
#                mysql -proot -e \"CREATE USER 'sportsbook_ipad'@'%' IDENTIFIED BY 'admin';\";\
#                mysql -proot -e \"GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES ON sportsbook_ipad.* TO 'sportsbook_ipad'@'%';\";\
#                mysql -proot -e \"GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES ON sportsbook_ipad_qa02.* TO 'sportsbook_ipad'@'%';\"",
#    require => [	Service["mysql"],
#    				Exec["mysql-root-passowrd"]],
#    path    => ['/bin', '/usr/bin']
#  }
#
#  exec {"Load-sportsbook_ipad-DATABASE":
#      onlyif       => "/usr/bin/test -f /vagrant/hermes-production.mysql.zip",
#      command      => 'unzip -p /vagrant/hermes-production.mysql.zip | mysql -usportsbook_ipad -padmin sportsbook_ipad && mv /vagrant/hermes-production.mysql.zip /vagrant/hermes-production.mysql.zip.processed',
#      require      => [  Service["mysql"],
#                    Exec["mysql-root-passowrd"],Exec['Create-drupal-db']],
#      path         => ['/bin', '/usr/bin'],
#  }
#
#  exec{"load-sportsbook_ipad_qa02_database":
#      onlyif       => "/usr/bin/test -f /vagrant/hermes-qa02.mysql.zip",
#      command      => 'unzip -p /vagrant/hermes-qa02.mysql.zip | mysql -usportsbook_ipad -padmin sportsbook_ipad_qa02 && mv /vagrant/hermes-production.mysql.zip /vagrant/hermes-production.mysql.zip.processed',
#      require      => [  Service["mysql"],
#                    Exec["mysql-root-passowrd"],Exec['Create-drupal-db']],
#      path         => ['/bin', '/usr/bin'],
#  }
#
#}
