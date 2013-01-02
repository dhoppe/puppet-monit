# = Class: monit::config
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
class monit::config (
  $ensure = hiera('ensure', $monit::params::ensure),
) inherits monit::params {
  validate_re($ensure, '^(absent|present)$')

  file {
    '/etc/default/monit':
      ensure  => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => "puppet:///modules/monit/${::lsbdistcodename}/etc/default/monit",
      notify  => Service['monit'],
      require => Package['monit'];
    '/etc/monit/conf.d':
      ensure  => directory,
      force   => true,
      purge   => true,
      recurse => true,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['monit'];
    '/etc/monit/monitrc':
      ensure  => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      content => template("monit/${::lsbdistcodename}/etc/monit/monitrc.erb"),
      notify  => Service['monit'],
      require => Package['monit'];
  }
}
