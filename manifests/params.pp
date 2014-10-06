# == Class hacme::params
#
# This class is meant to be called from hacme
# It sets variables according to platform
#
class hacme::params {

  if $::osfamily != 'Windows' { 
      fail("${::operatingsystem} not supported")
  }

  $hacme_src_url  = 'http://b2b-download.mcafee.com/products/tools/foundstone'
  $hacme_pkg_zip  = 'hacmebooks2_source.zip'
  $hacme_base     = 'C:/hacme'

}
