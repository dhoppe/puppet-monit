# = Class: monit::package
#
# This module manages monit
#
# == Parameters: none
#
# == Actions:
#
# == Requires: see Modulefile
#
# == Sample Usage:
#
class monit::package (
  $ensure = hiera('ensure', $monit::params::ensure),
) inherits monit::params {
  validate_re($ensure, '^(absent|present)$')

  package { 'monit':
    ensure => $ensure,
  }
}
