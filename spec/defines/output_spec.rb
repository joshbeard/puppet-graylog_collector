require 'spec_helper'

describe 'graylog_collector::output', :type => :define do
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
        :output_name => 'foo',
      }
    end

    it { is_expected.to contain_concat__fragment('output_foo').with({
      :target  => '/etc/graylog/collector/collector.conf',
    })}

  end
end
