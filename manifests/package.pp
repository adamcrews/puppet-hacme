# == Class hacme::package
#
# This class will fetch and uncompress the HacmeBooks package
#

class hacme::package inherits hacme { 

  if $caller_module_name != $module_name {
    fail ("Use of private class ${name} by ${caller_module_name}")
  }

  $base_zip = "${hacme_base}/${hacme_pkg_zip}"
  $full_url = "${hacme_src_url}/${hacme_pkg_zip}"

  file { $hacme_base:
    ensure => directory,
  }

  exec { 'Download Hacme':
    command   => "powershell.exe -Command (new-object System.Net.WebClient).DownloadFile(\'${full_url}\', \'${base_zip}\')",
    path      => 'C:\Windows\System32\WindowsPowerShell\v1.0',
    creates   => $base_zip,
    logoutput => true,
  }

  exec { 'Unzip Hacme':
    command => "powershell.exe -Command (new-object -com shell.application).namespace(\'${hacme_base}\').CopyHere((new-object -com shell.application).namespace(\'${base_zip}\').Items(),16)",
    path        => 'C:\Windows\System32\WindowsPowerShell\v1.0',
    logoutput   => true,
    subscribe   => Exec['Download Hacme'],
    require     => File[$hacme_base],
    creates     => "${hacme_base}/HacmeBooks",
    refreshonly => true,
  }
}
