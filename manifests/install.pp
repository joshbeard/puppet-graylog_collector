class graylog_collector::install {

  case $graylog_collector::install_from {

    'archive': {
      class { '::graylog_collector::install::archive':
        before => Class['::graylog_collector::config'],
      }
    }

    'package': {
      if $graylog_collector::manage_repo {
        class { '::graylog_collector::repo':
          before => Class['::graylog_collector::install::package'],
        }
      }
      class { '::graylog_collector::install::package':
        before => Class['::graylog_collector::config'],
      }
    }

  }

}
