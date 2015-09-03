# == Class: graylog_collector
#
class graylog_collector (
  $server_url,
  $enable_registration = true,
  $collector_id        = 'file:config/collector-id',
  $install_path        = '/usr/share',
  $config_dir          = '/etc/graylog-collector',
  $sysconfig_dir       = '/etc/default',
  $java_cmd            = '/usr/bin/java',
  $java_opts           = undef,
  $user                = 'root',
  $group               = '0',
  $manage_user         = false,
  $manage_group        = false,
  $manage_service      = true,
  $service_ensure      = 'running',
  $service_enable      = true,
  $service_name        = 'graylog-collector',
  $install_from        = 'archive',
  $version             = '0.4.0',
  $source_url          = 'https://packages.graylog2.org/releases/graylog-collector/graylog-collector-0.4.0.tgz',
) {

  # Graylog builds packages, but not for some platforms.
  unless $install_from == 'archive' {
    fail('archive is the only install method currently supported.')
  }

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
  validate_re($version, '^\d+\.\d+\.\d+')
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

  include '::graylog_collector::install::archive'
  include '::graylog_collector::config'

  anchor { 'graylog_collector::start': }
  anchor { 'graylog_collector::end': }

  if $manage_service {
    include '::graylog_collector::service'
    Class['::graylog_collector::config'] ~>
    Class['::graylog_collector::service']
  }

  Anchor['graylog_collector::start'] ->
  Class['::graylog_collector::install::archive'] ->
  Class['::graylog_collector::config'] ->
  Anchor['graylog_collector::end']

}
