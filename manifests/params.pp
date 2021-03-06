# == Class hacme::params
#
# This class is meant to be called from hacme
# It sets variables according to platform
#
class hacme::params {

  if $::osfamily != 'windows' { 
      fail("${::operatingsystem} not supported")
  }

  # The main system root
  $system_root = "C:\\"

  # program data
  $programdata = "${system_root}ProgramData"

  # Windows directory
  $windir = "${system_root}Windows"

  # System32 dir
  $system32 = "${windir}\\system32"

  # tmp installer files
  $installers = "${programdata}\\installers"

  # hacme zip info
  $hacme_src_url  = 'http://b2b-download.mcafee.com/products/tools/foundstone'
  $hacme_pkg_zip  = 'hacmebooks2_source.zip'
  $hacme_base     = 'C:/hacme'

  # Java stuff
  $java_version = '7'
  $java_update = '67'
  $java_build = '01'
  $java_src_url = 'http://download.oracle.com/otn-pub/java/jdk/'
  $java_arch = undef
  $java_referrer = 'http://edelivery.oracle.com'


}
