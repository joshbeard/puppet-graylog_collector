# == Class: graylog_collector
#
class graylog_collector (
  $server_url,
  $enable_registration = true,
  $collector_id        = 'file:/etc/graylog/collector/collector-id',
  $install_path        = '/usr/share',
  $config_dir          = '/etc/graylog/collector',
  $sysconfig_dir       = $graylog_collector::params::sysconfig_dir,
  $java_cmd            = '/usr/bin/java',
  $java_opts           = undef,
  $user                = 'root',
  $group               = 'root',
  $manage_user         = false,
  $manage_group        = false,
  $manage_init         = undef,
  $manage_service      = true,
  $service_ensure      = 'running',
  $service_enable      = true,
  $service_name        = 'graylog-collector',
  $service_file        = $graylog_collector::params::service_file,
  $service_template    = $graylog_collector::params::service_template,
  $manage_repo         = true,
  $install_from        = $graylog_collector::params::install_from,
  $version             = $graylog_collector::params::version,
  $source_url          = 'https://packages.graylog2.org/releases/graylog-collector/graylog-collector-0.4.1.tgz',
) inherits graylog_collector::params {

  validate_re($install_from, '(archive|package)')

  validate_re($server_url, '^https?:\/\/.*:\d+')

  validate_bool($enable_registration)
  validate_bool($manage_user)
  validate_bool($manage_group)

  validate_absolute_path($install_path)
  validate_absolute_path($config_dir)
  validate_absolute_path($sysconfig_dir)
  validate_absolute_path($java_cmd)
  if $java_opts {
    validate_string($java_opts)
  }

  validate_string($group)
  validate_string($user)
  validate_re($source_url, '^(https?|ftp)')

  if $manage_group {
    group { $group:
      ensure => 'present',
    }
  }

  if $manage_user {
    user { $user:
      ensure => 'present',
      gid    => $group,
      home   => $install_path,
    }
  }

  anchor { 'graylog_collector::start': }->
  class { 'graylog_collector::install': }->
  class { 'graylog_collector::config': }~>
  class { 'graylog_collector::service': }->
  anchor { 'graylog_collector::end': }

}
