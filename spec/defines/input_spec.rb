require 'spec_helper'

describe 'graylog_collector::input', :type => :define do
  let :pre_condition do
    "class { 'graylog_collector': server_url => 'http://foo:12900' }"
  end
  context "defaults" do
    let(:facts) do
      {
        :osfamily       => 'Redhat',
        :operatingsystemmajrelease => '6',
        :concat_basedir => '/tmp',
      }
    end
    let :title do
      'foo'
    end
    let :params do
      {
        :input_name => 'foo',
        :path       => '/var/log/foo/foo.log'
      }
    end

    it { is_expected.to contain_concat__fragment('input_foo').with({
      :target  => '/etc/graylog/collector/collector.conf',
      :content => /type = "file"/
    })}

    it { is_expected.to contain_concat__fragment('input_foo').with({
      :content => /path = "\/var\/log\/foo\/foo.log"/
    })}
  end
end
