class drush {

  exec { "download-drush":
    cwd     => "/usr/local/share",
    onlyif  => "/usr/bin/test ! -d /usr/local/share/drush",
    command => "/usr/bin/wget --no-check-certificate -O - http://ftp.drupal.org/files/projects/drush-7.x-5.8.tar.gz | tar zxf -",
  }

  file { "/usr/local/share/drush":
    ensure => directory,
    recurse => true,
    mode => 777,
    require => Exec['download-drush']
  }

  exec { "link-drush-bin":
    path    => "/bin",
    require => File["/usr/local/share/drush"],
    onlyif  => "/usr/bin/test ! -L /usr/bin/drush",
    command => "ln -s /usr/local/share/drush/drush /usr/local/bin/drush",
  }
#  file { "/usr/local/share/drush/drushrc.php":
#    ensure  => "link",
#    target  => "/vagrant/puppet/config/drush/drushrc.php",
#    require => Exec["link-drush-bin"],
#  }
}