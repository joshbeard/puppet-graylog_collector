require 'spec_helper'

describe 'graylog_collector::config' do
  let :pre_condition do
    "class { 'graylog_collector': server_url => 'http://foo:12900' }"
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({:concat_basedir => '/tmp'})
      end

      it { is_expected.to contain_exec('/etc/graylog/collector') }
      it { is_expected.to contain_concat('/etc/graylog/collector/collector.conf') }

      case facts[:osfamily]
      when /Redhat/i
        it { is_expected.to contain_file('/etc/sysconfig/graylog-collector') }
      when 'Debian'
        it { is_expected.to contain_file('/etc/default/graylog-collector') }
      end

    end
  end
end
