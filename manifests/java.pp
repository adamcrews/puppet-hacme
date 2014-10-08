# == Class: hacme::java
#
# Downloads and installs Oracle Java
# This implies you accept Oracle's Java SE license from:
# http://www.oracle.com/technetwork/java/javase/terms/license/index.html
#
# Module heavily copied from:
# https://github.com/counsyl/puppet-windows/blob/master/manifests/java.pp
class hacme::java inherits hacme {

  # If user passed in architecture parameter, use it for `$java_arch`,
  # otherwise use i586 (for x86 systems).
  if $java_arch {
    $arch = $java_arch
  } else {
    case $::architecture {
      'x64': {
        $arch = 'x64'
      }
      'x86': {
        $arch = 'i586'
      }
      default: {
        fail("Unknown architecture for JRE: ${::architecture}")
      }
    }
  }

  # Determining Java's path depending on the version.
  case $java_version {
    '6': {
      $path = "C:\\Program Files\\Java\\jre1.6.0_${java_update}\\bin"
    }
    '7': {
      $path = 'C:\Program Files\Java\jre7\bin'
    }
    default: {
      fail("Do not know how to install Java version: ${java_version}.\n")
    }
  }

  # Setting up variables for downloading the JRE.
  $jre_basename = "jre-${java_version}u${java_update}-windows-${arch}.exe"
  $jre_installer = "${installers}\\${jre_basename}"
  $jre_url = "${java_src_url}${java_version}u${java_update}-b${java_build}/${jre_basename}"
  $cookie = "oraclelicense=accept-securebackup-cookie;gpw_e24=${java_referrer}"

  # Download the JRE using a PowerShell script that sets the license accepted cookie.
  exec { 'download-java':
    command => template("${module_name}/download_java.ps1.erb"),
    path    => 'C:\Windows\System32\WindowsPowerShell\v1.0',
    creates => $jre_installer,
    require => File[$installers],
  }

  # Determining the Java package name.
  if $arch == 'x64' {
    $java_package = "Java ${java_version} Update ${java_update} (64-bit)"
  } else {
    $java_package = "Java ${java_version} Update ${java_update}"
  }

  package { $java_package:
    ensure          => installed,
    source          => $jre_installer,
    install_options => ['/s'],
    require         => Exec['download-java'],
  }
}
