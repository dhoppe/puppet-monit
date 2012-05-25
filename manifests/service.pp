define monit::service( $owner = 'root', $group = 'root', $mode = '0644', $source = 'UNSET' , $content = 'UNSET' ) {

  if $source  == 'UNSET' {
    $real_source = "puppet:///modules/monit/common/etc/monit/conf.d/${name}"
  }
  else {
    $real_source = $source
  }

  $file = "/etc/monit/conf.d/${name}"
  $require = [ File['/etc/monit/conf.d'], Package['monit'] ]

  if $content != 'UNSET' {
    file {
      "${file}" :
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        content => $content,
        notify  => Service['monit'],
        require => $require;
    }
  }
  else {
    file {
      "${file}" :
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        source  => $real_source,
        notify  => Service['monit'],
        require => $require;
    }
  }
}
