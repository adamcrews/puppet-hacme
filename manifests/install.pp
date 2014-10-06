# == Class hacme::install
#
class hacme::install {

  package { $hacme::package_name:
    ensure => present,
  }
}
