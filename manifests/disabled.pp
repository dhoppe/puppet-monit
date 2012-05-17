class monit::disabled inherits monit {
  Service['monit'] {
    ensure => stopped,
    enable => false,
  }
}