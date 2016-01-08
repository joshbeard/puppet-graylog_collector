# == Class: graylog_collector::service
#
class graylog_collector::service (
    $service_ensure   = $::graylog_collector::service_ensure,
    $service_enable   = $::graylog_collector::service_enable,
    $service_name     = $::graylog_collector::service_name,
    $service_file     = $::graylog_collector::service_file,
    $service_template = $::graylog_collector::service_template,
    $user             = $::graylog_collector::user,
    $install_path     = $::graylog_collector::install_path,
    $config_dir       = $::graylog_collector::config_dir,
    $sysconfig_dir    = $::graylog_collector::sysconfig_dir,
    $java_cmd         = $::graylog_collector::java_cmd,
) {

  #
  # If we're installing from archive, default to managing the init script
  # If we're installing from package, default to NOT managing it
  #
  case $::graylog_collector::install_from {
    'archive': {
      if $::graylog_collector::manage_init == undef {
        $manage_init = true
      }
      else {
        $manage_init = $::graylog_collector::manage_init
      }
    }
    'package': {
      if $::graylog_collector::manage_init == undef {
        $manage_init = false
      }
      else {
        $manage_init = $::graylog_collector::manage_init
      }
    }
    default: {
      fail("Unknown installation method: ${::graylog_collector::install_from}")
    }
  }

  if $manage_init {
    file { 'graylog_service':
      ensure  => 'file',
      path    => $service_file,
      content => template($service_template),
      owner   => 'root',
      group   => '0',
      mode    => '0755',
      notify  => Service['graylog-collector'],
    }
  }

  if $::graylog_collector::manage_service {
    service { 'graylog-collector':
      ensure => $service_ensure,
      enable => $service_enable,
      name   => $service_name,
    }
  }

}
