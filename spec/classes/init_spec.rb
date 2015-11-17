require 'spec_helper'

describe 'graylog_collector' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({:concat_basedir => '/tmp'})
        end

        context "no server_url with default parameters" do
          let(:params) {{ }}

          it { expect { catalogue }.to raise_error(Puppet::Error, /does not match/) }
        end

        context "enable_registration = false" do
          let(:params) {{ :enable_registration => false }}

          it { is_expected.to contain_class('graylog_collector') }
          it { is_expected.to contain_class('graylog_collector::install') }
          it { is_expected.to contain_class('graylog_collector::config') }
          it { is_expected.to contain_class('graylog_collector::service') }

          it { is_expected.not_to contain_user('root') }
          it { is_expected.not_to contain_group('root') }
        end

        context "graylog_collector class without any parameters" do
          let(:params) {{ :server_url => 'https://localhost:12900' }}

          it { is_expected.to contain_class('graylog_collector') }
          it { is_expected.to contain_class('graylog_collector::install') }
          it { is_expected.to contain_class('graylog_collector::config') }
          it { is_expected.to contain_class('graylog_collector::service') }

          it { is_expected.not_to contain_user('root') }
          it { is_expected.not_to contain_group('root') }
        end

      end
    end
  end

  context 'unsupported operating systems' do
    context 'on windows' do
      let(:facts) {{ :osfamily => 'windows' }}
      let(:params) {{ :server_url => 'https://localhost:12900' }}
      it { expect { catalogue }.to raise_error(Puppet::Error, /not support/) }
    end
  end

end
