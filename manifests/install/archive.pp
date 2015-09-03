# == Class: graylog_collector::install::archive
#
# Class to manage the installation of Graylog Collector from a compressed
# archive.
#
class graylog_collector::install::archive {

  $filename = basename($::graylog_collector::source_url)

  file { $::graylog_collector::install_path:
    ensure => 'directory',
    owner  => 'root',
    group  => '0',
  }

  file { '/usr/share/graylog-collector':
    ensure => 'link',
    target => "${::graylog_collector::install_path}/graylog-collector-${::graylog_collector::version}",
  }

  file { '/var/log/graylog-collector':
    ensure => 'directory',
    owner  => $::graylog_collector::user,
    group  => $::graylog_collector::group,
  }

  staging::file { $filename:
    source => $::graylog_collector::source_url,
  }

  staging::extract { $filename:
    target  => $::graylog_collector::install_path,
    creates => "${::graylog_collector::install_path}/graylog-collector-${::graylog_collector::version}",
    require => Staging::File[$filename],
  }

}
