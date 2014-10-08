# == Class: hacme
#
# Full description of class hacme here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class hacme (
  $system_root    = $hacme::params::system_root,
  $programdata    = $hacme::params::programdata,
  $windir         = $hacme::params::windir,
  $system32       = $hacme::params::system32,
  $installers     = $hacme::params::installers,

  $hacme_src_url  = $hacme::params::hacme_src_url,
  $hacme_pkg_zip  = $hacme::params::hacme_pkg_zip,
  $hacme_base     = $hacme::params::hacme_base,

  $java_version   = $hacme::params::java_version,
  $java_update    = $hacme::params::java_update,
  $java_build     = $hacme::params::java_build,
  $java_src_url   = $hacme::params::java_src_url,
  $java_arch      = $hacme::params::java_arch,
  $java_referrer  = $hacme::params::java_referrer,

) inherits hacme::params {

  anchor { 'hacme::begin': } ->
    file { $installers:
      ensure => directory,
    } ->

    class { 'hacme::package': } ->
    class { 'hacme::java': } ->

  anchor { 'hacme::end': }

}
