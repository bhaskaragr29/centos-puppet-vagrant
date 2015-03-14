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

#    firewall { '101 allow httpd':
#      chain   => 'INPUT',
#      state   => ['NEW'],
#      dport   => '82',
#      proto   => 'tcp',
#      action  => 'accept',
#    }
}