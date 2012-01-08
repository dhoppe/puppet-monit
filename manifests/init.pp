class monit {
	file { "/etc/default/monit":
		owner   => root,
		group   => root,
		mode    => 0644,
		alias   => "monit",
		source  => "puppet:///modules/monit/$lsbdistcodename/etc/default/monit",
		notify  => Service["monit"],
		require => Package["monit"],
	}

	file { "/etc/monit/conf.d":
		ensure  => directory,
		owner   => root,
		group   => root,
		mode    => 0755,
		require => Package["monit"],
	}

	file { "/etc/monit/monitrc":
		owner   => root,
		group   => root,
		mode    => 0600,
		alias   => "monitrc",
		content => template("monit/$lsbdistcodename/etc/monit/monitrc.erb"),
		notify  => Service["monit"],
		require => Package["monit"],
	}

	package { "monit":
		ensure => present,
	}

	service { "monit":
		enable     => true,
		ensure     => running,
		hasrestart => true,
		hasstatus  => false,
		require    => [
			File["monit"],
			File["monitrc"],
			Package["monit"]
		],
	}
}

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