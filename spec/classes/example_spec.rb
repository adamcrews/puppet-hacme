require 'spec_helper'

describe 'hacme' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "hacme class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('hacme::params') }
        it { should contain_class('hacme::install').that_comes_before('hacme::config') }
        it { should contain_class('hacme::config') }
        it { should contain_class('hacme::service').that_subscribes_to('hacme::config') }

        it { should contain_service('hacme') }
        it { should contain_package('hacme').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'hacme class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('hacme') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
