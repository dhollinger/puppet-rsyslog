require 'spec_helper'
require 'yaml'

describe 'rsyslog::component::legacy_config', :include_rsyslog => true do
  let(:title) { 'mylegacy_rules' }

  context 'key/value legacy rules' do
    let(:params) {{
      :priority     => 40,
      :target       => '50_rsyslog.conf',
      :confdir      => '/etc/rsyslog.d',
      :key          => "auth,authpriv.*",
      :value        => "/var/log/auth.log",
    }}

    it do
      is_expected.to contain_concat__fragment('rsyslog::component::legacy_config::mylegacy_rules').with_content(
        /(?x)# mylegacy_rules\n
        ^auth,authpriv\.\*\s*\/var\/log\/auth.log\s*\n
        /)
    end
  end

    context 'oneline legacy rules' do
      let(:params) {{
        :priority     => 40,
        :target       => '50_rsyslog.conf',
        :type         => 'legacy',
        :value        => "*.* @@logmonster.cloud.local",
      }}

      it do
        is_expected.to contain_concat__fragment('rsyslog::component::legacy_config::mylegacy_rules').with_content(
          /(?x)# mylegacy_rules\n
          ^\*\.\*\s+@@logmonster.cloud.local\s*\n
          /)
      end
    end

end
    

