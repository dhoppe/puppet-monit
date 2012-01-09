define monit::service() {
	file { "/etc/monit/conf.d/${name}":
		owner   => root,
		group   => root,
		mode    => 0644,
		source  => "puppet:///modules/monit/common/etc/monit/conf.d/$name",
		notify  => Service["monit"],
		require => Package["monit"],
	}
}

# vim: tabstop=3