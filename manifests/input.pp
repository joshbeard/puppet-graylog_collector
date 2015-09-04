# == Define: graylog_collector::input
#
# Defined type to manage Graylog Collector input configurations
#
define graylog_collector::input (
  $input_name               = $title,
  $path                     = undef,
  $type                     = 'file',
  $path_glob_root           = undef,
  $path_glob_pattern        = undef,
  $content_splitter         = 'NEWLINE',
  $content_splitter_pattern = undef,
  $charset                  = 'UTF-8',
  $reader_interval          = '100ms',
  $priority                 = '101',
  $config_dir               = $graylog_collector::config::config_dir,
  $global_message_fields    = {},
  $message_fields           = {},
  $outputs                  = undef,
) {

  if $path {
    validate_string($path)
  }

  if $path_glob_root {
    validate_string($path_glob_root)
  }

  if $path_glob_pattern {
    validate_string($path_glob_pattern)
  }

  validate_re($content_splitter, '(NEWLINE|PATTERN)')

  if $content_splitter == 'PATTERN' {
    validate_string($content_splitter_pattern)
  }

  validate_re($reader_interval, '^\d+(ms|s|m)')

  if $outputs {
    validate_array($outputs)
  }

  validate_hash($global_message_fields)
  validate_hash($message_fields)

  $_message_fields = merge($global_message_fields, $message_fields)


  # We parameterize this, even though it must be 'file'.
  # http://docs.graylog.org/en/1.1/pages/collector.html#file-input
  unless $type == 'file' {
    fail("${title}: type must be file")
  }

  concat::fragment { "input_${input_name}":
    target  => "${config_dir}/collector.conf",
    content => template('graylog_collector/input.erb'),
    order   => $priority,
  }

}
