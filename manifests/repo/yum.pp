class graylog_collector::repo::yum {

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-graylog-collector':
    ensure => 'file',
    source => 'puppet:///modules/graylog_collector/RPM-GPG-KEY-graylog-collector',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  yumrepo { 'graylog-collector':
    ensure   => 'present',
    descr    => 'graylog-collector',
    baseurl  => 'https://packages.graylog2.org/repo/el/$releasever/collector-latest/$basearch/',
    gpgcheck => '1',
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-graylog-collector',
    require  => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-graylog-collector'],
  }

  Yumrepo['graylog-collector'] -> Package<|title == 'graylog-collector'|>

}
