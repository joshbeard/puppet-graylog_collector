# == Define: graylog_collector::output
#
# Defined type to manage Graylog Collector output configurations
#
define graylog_collector::output (
  $output_name                = $title,
  $type                       = gelf,
  $host                       = undef,
  $port                       = undef,
  $client_tls                 = false,
  $client_tls_cert_chain_file = undef,
  $client_tls_verify_cert     = true,
  $client_queue_size          = '512',
  $client_connect_timeout     = '5000',
  $client_reconnect_delay     = '1000',
  $client_tcp_no_delay        = true,
  $client_send_buffer_size    = '-1',
  $inputs                     = undef,
  $priority                   = '401',
  $config_dir                 = $graylog_collector::config::config_dir,
) {

  validate_re($type, '(stdout|gelf)')

  if ($type == 'gelf') {
    validate_string($host)
    validate_string($port)
  }

  if ($type == 'stdout') {
    if $host {
      warn('host is invalid for type stdout')
    }
    if $port {
      warn('port is invalid for type stdout')
    }
  }

  validate_re($client_queue_size, '\d+')
  validate_re($client_connect_timeout, '\d+')
  validate_re($client_reconnect_delay, '\d+')
  validate_re($client_send_buffer_size, '-?\d+')

  if $inputs {
    validate_array($inputs)
  }

  concat::fragment { "output_${output_name}":
    target  => "${config_dir}/collector.conf",
    content => template('graylog_collector/output.erb'),
    order   => $priority,
  }
}
