require 'spec_helper'

describe 'graylog_collector::install' do
  context 'supported operating systems' do

    let :pre_condition do
      "class { 'graylog_collector': server_url => 'http://foo:12900' }"
    end

    on_supported_os.each do |os, facts|
      context "on #{os} #{facts[:osfamily]} #{facts[:operatingsystem]} #{facts[:operatingsystemmajrelease]}" do

        let(:facts) do
          facts.merge({:concat_basedir => '/tmp'})
        end

        case facts[:osfamily]
        when 'Redhat'
          case facts[:operatingsystemmajrelease]
          when '7'
            it { is_expected.to contain_class('graylog_collector::repo') }
            it { is_expected.to contain_class('graylog_collector::install::package') }
            it { is_expected.to contain_class('graylog_collector::repo::yum') }
          when '6'
            it { is_expected.to contain_class('graylog_collector::install::archive') }
          end
        when 'Debian'
          case facts[:operatingsystem]
          when 'Ubuntu'
            if facts[:operatingsystemmajrelease] =~ /^(12|14)/
              it { is_expected.to contain_class('graylog_collector::repo') }
              it { is_expected.to contain_class('graylog_collector::install::package') }
              it { is_expected.to contain_class('graylog_collector::repo::apt') }
            else
              it { is_expected.to contain_class('graylog_collector::install::archive') }
            end
          when 'Debian'
            if facts[:operatingsystemmajrelease] == '8'
              it { is_expected.to contain_class('graylog_collector::repo') }
              it { is_expected.to contain_class('graylog_collector::install::package') }
            else
              it { is_expected.to contain_class('graylog_collector::install::archive') }
            end
          end
        end
      end
    end
  end
end
