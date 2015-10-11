require 'spec_helper'

describe 'graylog_collector::service' do
  context 'supported operating systems' do

    let :pre_condition do
      "class { 'graylog_collector': server_url => 'http://foo:12900' }"
    end

    context 'with defaults' do

      on_supported_os.each do |os, facts|
        context "on #{os}" do
          let(:facts) do
            facts.merge({:concat_basedir => '/tmp'})
          end

          describe "manages service" do
            it { is_expected.to contain_service('graylog-collector').with({
              :ensure => 'running',
              :enable => true,
              :name   => 'graylog-collector',
            })}
          end

          case facts[:osfamily]
          when /Redhat/i
            case facts[:operatingsystemmajrelease]
            when '7'
              describe "does not manage init script" do
                it { is_expected.not_to contain_file('graylog_service') }
              end
            else
              describe 'manages init script' do
                it { is_expected.to contain_file('graylog_service').with({
                  :path => '/etc/init.d/graylog-collector'
                })}
              end
            end
          when 'Debian'
            case facts[:operatingsystem]
            when 'Ubuntu'
              if facts[:operatingsystemmajrelease] =~ /^(12|14)/
                describe 'does not manage init script' do
                  it { is_expected.not_to contain_file('graylog_service') }  
                end
              else
                describe 'manages an init script' do
                  it { is_expected.to contain_file('graylog_service') }  
                end
              end
            when 'Debian'
              if facts[:operatingsystemmajrelease] == '8'
                describe 'does not manage init script' do
                  it { is_expected.not_to contain_file('graylog_service') }  
                end
              else
                describe 'manages an init script' do
                  it { is_expected.to contain_file('graylog_service') }  
                end
              end
            end
          else
            describe 'manages an init script' do
              it { is_expected.to contain_file('graylog_service') }  
            end
          end

        end
      end
    end

  end
end
