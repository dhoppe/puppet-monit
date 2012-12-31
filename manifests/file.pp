# = Define: monit::file
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
define monit::file() {
  file { "/etc/monit/conf.d/${name}":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///modules/monit/common/etc/monit/conf.d/${name}",
    notify  => Service['monit'],
    require => Class['monit::config'],
  }
}
