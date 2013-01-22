# = Class: monit
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
class monit {
  class { 'monit::package': }
  class { 'monit::config': }
  class { 'monit::service': }
}
