
stage {'pre':
	before => Stage['main']
}

stage {'post':
    require => Stage['main'],
}

class {'customfirewall':
  stage => 'post'
}

package {
	'unzip': ensure => installed;
	'git'  : ensure=>installed;
}

yumrepo { "remi-repo":
  baseurl  => "http://rpms.famillecollet.com/enterprise/6/remi/x86_64",
  descr    => "remi repo",
  enabled  => 1,
  gpgcheck => 0,
}

class cntlm{

	package { 'cntlm':
  			ensure => '0.92.3-1',
  			provider 	=> 'rpm',
			source  	=> '/vagrant/cntlm-0.92.3-1.x86_64.rpm',
	}

	# file{ '/etc/cntlm.conf':
	# 	path	=> '/etc/cntlm.conf',
	# 	require => Package['cntlm'],
	# 	source => '/vagrant/puppet/cntlm.conf',
	# 	owner	=> 'root',
	# 	mode	=> 0600,
	# 	notify =>  Service['cntlmd'],
	# }

	# augeas{"yum-cntlm" :
 #  		context => "/etc/yum.conf",
 #  		changes => "proxy = http://127.0.0.1:3128",
 #  		onlyif  => "match other_value size > 0",
	# }

	# service { 'cntlmd':
	# 	enable      => true,
	# 	ensure      => running,
	# 	require    => [Package["cntlm"], File['/etc/cntlm.conf']],
	# }
}


class {'jenkins':
  configure_firewall => false,
  executors => 0,
}


include httpd, php,phpunit,jenkins
include '::mysql::server'
# node 'mysqlserver.box'{
# 	include mysql
# 	#include cntlm
# }

# node 'webserver.box'{
# 	include php
# }