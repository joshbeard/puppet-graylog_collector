# == Class: graylog_collector::config
#
# Manage the configuration for Graylog Collector
#
class graylog_collector::config (
  $config_dir  = $::graylog_collector::config_dir,
  $java_cmd    = $::graylog_collector::java_cmd,
  $java_opts   = $::graylog_collector::java_opts,
) {

  file { $config_dir:
    ensure => 'directory',
    owner  => $::graylog_collector::user,
    group  => $::graylog_collector::group,
  }

  concat { "${config_dir}/collector.conf":
    ensure => present,
    owner  => $::graylog_collector::user,
    group  => $::graylog_collector::group,
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
  }

}
