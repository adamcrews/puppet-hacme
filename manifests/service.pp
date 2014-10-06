# == Class hacme::service
#
# This class is meant to be called from hacme
# It ensure the service is running
#
class hacme::service {

  service { $hacme::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
