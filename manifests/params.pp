class graylog_collector::params {

  case $::osfamily {
    'RedHat': {
      $sysconfig_dir = '/etc/sysconfig'
      if $::operatingsystemmajrelease == '7' {
        $service_file     = '/usr/lib/systemd/system/graylog-collector.service'
        $service_template = 'graylog_collector/graylog-collector.service.erb'
        $install_from     = 'package'
      }
      elsif $::operatingsystemmajrelease == '6' or $::operatingsystem == 'Amazon'{
        $service_file     = '/etc/init.d/graylog-collector'
        $service_template = 'graylog_collector/graylog-collector.init.erb'
        $install_from     = 'archive'
      }
      else {
        fail("${::osfamily} is not supported by ${module_name}")
      }
    }
    'Debian': {
      $sysconfig_dir = '/etc/default'
      if $::operatingsystem == 'Ubuntu' {
        $service_file     = '/etc/init/graylog-collector.conf'
        $service_template = 'graylog_collector/graylog-collector.upstart.erb'

        if $::operatingsystemmajrelease =~ /^(12|14)/ {
          $install_from = 'package'
        }
        else {
          $install_from = 'archive'
        }
      }
      else {
        $service_file     = '/etc/init.d/graylog-collector'
        $service_template = 'graylog_collector/graylog-collector.init.erb'

        if $::operatingsystemmajrelease == '8' {
          $install_from = 'package'
        }
        else {
          $install_from = 'archive'
        }
      }
    }
    default: {
      $sysconfig_dir    = '/etc/default'
      $service_file     = '/etc/init.d/graylog-collector'
      $service_template = 'graylog_collector/graylog-collector.init.erb'
      $install_from     = 'archive'
    }
  }

  if $install_from == 'package' {
    $version = 'installed'
  }
  else {
    $version = '0.4.1'
  }

}
