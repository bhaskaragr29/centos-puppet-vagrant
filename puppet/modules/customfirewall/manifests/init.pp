class customfirewall{

#  resources { "firewall":
#    purge => true
#  }



  Firewall {
    before  => Class['customfirewall::post'],
    require => Class['customfirewall::prev'],
  }

  class { ['customfirewall::prev', 'customfirewall::post']: }
  class { 'firewall': }
}
