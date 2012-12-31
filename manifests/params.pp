# = Class: monit::params
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
class monit::params {
  case $::lsbdistcodename {
    'squeeze': {
      $ensure         = present
      $ensure_enable  = true
      $ensure_running = running
      $ensure_status  = false
      $disabled_hosts = []
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}
