class httpd{

	package {"httpd":
		ensure => 'installed',
	}	

	service { 'httpd':
		enable      => true,
		ensure      => 'running',
		require		=> Package["httpd"]
	}

	file{ '/etc/httpd.conf':
		path	=> '/etc/httpd/conf/httpd.conf',
		require => Package['httpd'],
		source => "puppet:///modules/httpd/httpd.conf",
		owner	=> 'root',
		mode	=> 0600,
		notify =>  Service['httpd'],
	}

  host { 'testcms.paddypower.com':
    ip => '127.0.0.1',
  }

}