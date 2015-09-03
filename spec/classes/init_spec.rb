require 'spec_helper'

describe 'graylog_collector' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "graylog_collector class without any parameters" do
          let(:params) {{ }}

          it { should contain_class('graylog_collector') }

        end
      end
    end
  end

end
