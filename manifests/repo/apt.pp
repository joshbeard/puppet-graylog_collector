class graylog_collector::repo::apt {

  file { '/etc/apt/trusted.gpg.d/graylog-collector-keyring.gpg':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
    source => 'puppet:///modules/graylog_collector/graylog-collector-keyring.gpg',
  }

  apt::source { 'graylog-collector':
    location => 'https://packages.graylog2.org/repo/debian/',
    release  => $::lsbdistcodename,
    repos    => 'collector-latest',
    pin      => '200',
    require  => File['/etc/apt/trusted.gpg.d/graylog-collector-keyring.gpg']
  }

  Apt::Source['graylog-collector'] -> Package<|title == 'graylog-collector'|>

}
