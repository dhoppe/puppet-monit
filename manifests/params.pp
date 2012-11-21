class monit::params {
  case $::lsbdistcodename {
    'squeeze', 'maverick', 'natty': {
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}
