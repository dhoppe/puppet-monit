class monit::params {
  case $::lsbdistcodename {
    'squeeze': {
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}
