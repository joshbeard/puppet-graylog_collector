# == Class: graylog_collector::config
#
# Manage the configuration for Graylog Collector
#
class graylog_collector::config (
  $config_dir          = $::graylog_collector::config_dir,
  $java_cmd            = $::graylog_collector::java_cmd,
  $java_opts           = $::graylog_collector::java_opts,
  $server_url          = $::graylog_collector::server_url,
  $enable_registration = $::graylog_collector::enable_registration,
  $collector_id        = $::graylog_collector::collector_id,
) {

  # The default config_dir is /etc/graylog/collector
  # I don't want to manage '/etc/graylog' in this module, though, so we're
  # using mkdir -p here.
  exec { $config_dir:
    command => "/bin/mkdir -p ${config_dir}",
    creates => $config_dir,
  }

  concat { "${config_dir}/collector.conf":
    ensure  => present,
    owner   => $::graylog_collector::user,
    group   => $::graylog_collector::group,
    require => Exec[$config_dir],
  }

  Concat::Fragment {
    target  => "${config_dir}/collector.conf",
  }

  concat::fragment { 'config_head':
    content => template('graylog_collector/config_head.conf.erb'),
    order   => '01',
  }

  concat::fragment { 'input_head':
    content => "inputs {\n",
    order   => '100',
  }

  concat::fragment { 'input_foot':
    content => "}\n\n",
    order   => '300',
  }

  concat::fragment { 'output_head':
    content => "outputs {\n",
    order   => '400',
  }

  concat::fragment { 'output_foot':
    content => "}\n",
    order   => '600',
  }

  file { "${::graylog_collector::sysconfig_dir}/graylog-collector":
    ensure  => 'file',
    owner   => 'root',
    group   => '0',
    content => template('graylog_collector/graylog-collector.erb'),
    require => Exec[$config_dir],
  }

}
