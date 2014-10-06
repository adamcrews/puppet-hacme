class hacme::package (

  $hacme_src_url  = $hacme::params::hacme_src_url,
  $hacme_pkg_zip  = $hacme::params::hacme_pkg_zip,
  $hacme_base     = $hacme::params::hacme_base,
  
) inherits hacme::params { 

  file { $hacme_base:
    ensure => directory,
  }

  exec { 'Download Hacme':
    #command   => "powershell.exe -Command (new-object System.Net.WebClient).DownloadFile(\'${hacme_src_url}/${hacme_pkg_zip}\', \'C:\\hacme\\${hacme_pkg_zip}\')",
    command   => "powershell.exe -Command (new-object System.Net.WebClient).DownloadFile(\'${hacme_src_url}/${hacme_pkg_zip}\', \'${hacme_base}/${hacme_pkg_zip}\')",
    path      => 'C:\Windows\System32\WindowsPowerShell\v1.0',
    #creates   => "C:\\hacme\\${hacme_pkg_zip}",
    creates   => "${hacme_base}/${hacme_pkg_zip}",
    logoutput => true,
  }

  exec { 'Unzip Hacme':
    command     => "powershell.exe -Command (new-object -com shell.application).namespace(\'${hacme_base}').CopyHere((new-object -com shell.application).namespace(\'${hacme_base}/${hacme_pkg_zip}\').Items(),16)",
    path        => 'C:\Windows\System32\WindowsPowerShell\v1.0',
    logoutput   => true,
    subscribe   => Exec['Download Hacme'],
    require     => File[$hacme_base],
    creates     => "${hacme_base}/HacmeBooks",
    refreshonly => true,
  }
}
