# == Class: graylog_collector::service
#
class graylog_collector::service (
    $service_ensure = $::graylog_collector::service_ensure,
    $service_enable = $::graylog_collector::service_enable,
    $service_name   = $::graylog_collector::service_name,
    $user           = $::graylog_collector::user,
) {

  file { 'graylog_service':
    ensure  => 'file',
    path    => "/etc/init.d/${service_name}",
    content => template('graylog_collector/graylog-collector.init.erb'),
    owner   => 'root',
    group   => '0',
    mode    => '0755',
  }

  service { 'graylog-collector':
    ensure    => $service_ensure,
    enable    => $service_enable,
    name      => $service_name,
    subscribe => File['graylog_service'],
  }

}
