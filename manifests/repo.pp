class graylog_collector::repo {

  case $::osfamily {
    'RedHat': {
      class { 'graylog_collector::repo::yum': }
    }
    'Debian': {
      class { 'graylog_collector::repo::apt': }
    }
    default: {
      fail("Unsupported operating system ${::osfamily} for graylog repo")
    }
  }

}
