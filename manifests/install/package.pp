class graylog_collector::install::package {

  package { 'graylog-collector':
    ensure => $graylog_collector::version,
  }

}
