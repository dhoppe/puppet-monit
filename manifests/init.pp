class monit {
	file { "/etc/default/monit":
		owner   => root,
		group   => root,
		mode    => 0644,
		alias   => "monit",
		notify  => Service["monit"],
		source  => "puppet:///modules/monit/$lsbdistcodename/etc/default/monit",
		require => Package["monit"],
	}

	file { "/etc/monit/conf.d":
		ensure  => directory,
		owner   => root,
		group   => root,
		mode    => 0700,
		require => Package["monit"],
	}

	file { "/etc/monit/monitrc":
		owner   => root,
		group   => root,
		mode    => 0600,
		alias   => "monitrc",
		notify  => Service["monit"],
		content => template("monit/$lsbdistcodename/etc/monit/monitrc.erb"),
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
		mode    => 0600,
		notify  => Service["monit"],
		source  => "puppet:///modules/monit/common/etc/monit/conf.d/$name",
		require => Package["monit"],
	}
}

# vim: tabstop=3