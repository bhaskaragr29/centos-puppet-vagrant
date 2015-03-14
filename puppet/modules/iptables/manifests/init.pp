class iptables {

 service { "iptables":
    ensure => "running",
    enable =>  true,
    hasstatus   => true,
    hasrestart  => true,
  }

  file { "/etc/sysconfig/iptables":
    ensure  => "link",
    target  => "puppet:///modules/iptables/iptables",
    force   => true,
    notify  => Service["iptables"],
  }
}
