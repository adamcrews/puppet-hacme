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

) inherits hacme::params {

  # validate parameters here

  class { 'hacme::package': } ->
  #class { 'hacme::java': } ->

  #class { 'hacme::service': } ->
  Class['hacme']
}
