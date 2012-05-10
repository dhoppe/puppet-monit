class monit::disabled inherits monit {
  Service['monit'] {
    enable => false,
    ensure => stopped,
  }
}