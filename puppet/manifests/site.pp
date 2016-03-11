
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
#    "epel-release":     ensure   => present,
#                        source   => "http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm",
#                        provider => rpm;
     "webstatic":       ensure  =>  present,
                        source  => "https://mirror.webtatic.com/yum/el6/latest.rpm",
                        provider=> rpm;
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

	file{ '/etc/cntlm.conf':
		path	=> '/etc/cntlm.conf',
		require => Package['cntlm'],
		source => '/vagrant/puppet/cntlm.conf',
		owner	=> 'root',
		mode	=> 0600,
		notify =>  Service['cntlmd'],
	}



	service { 'cntlmd':
		enable      => true,
		ensure      => running,
		require    => [Package["cntlm"], File['/etc/cntlm.conf']],
	}
}


class {'jenkins':
  configure_firewall => false,
  executors => 4,
}


include httpd, php,phpunit,jenkins
include '::mysql::server'
include drush