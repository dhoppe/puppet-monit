# = Class: monit::service
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
class monit::service (
  $ensure_enable  = hiera('ensure_enable', $monit::params::ensure_enable),
  $ensure_running = hiera('ensure_running', $monit::params::ensure_running),
  $ensure_status  = $monit::params::ensure_status,
  $disabled_hosts = hiera('disabled_hosts', $monit::params::disabled_hosts),
) inherits monit::params {
  validate_bool($ensure_enable)
  validate_re($ensure_running, '^(running|stopped)$')
  validate_bool($ensure_status)
  validate_array($disabled_hosts)

  service { 'monit':
    ensure     => $ensure_running,
    enable     => $ensure_enable,
    hasrestart => true,
    hasstatus  => $ensure_status,
    require    => Class['monit::config'],
  }

  if $::hostname in $disabled_hosts {
    Service <| title == 'monit' |> {
      ensure => stopped,
      enable => false,
    }
  }
}
