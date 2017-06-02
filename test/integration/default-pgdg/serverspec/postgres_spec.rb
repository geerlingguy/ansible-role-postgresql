require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('postgresql-9.5'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end
describe package('postgresql95'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe service('postgresql') do
  it { should be_enabled   }
  it { should be_running   }
end  

describe process("postgres") do
  its(:user) { should eq "postgres" }
## not on centos
#  its(:args) { should match /main\/postgresql.conf/ }
end

describe port(5432) do
  it { should be_listening }
end

describe file('/var/lib/postgresql/9.5/main'), :if => os[:family] == 'ubuntu' do
  it { should be_directory }
end
describe file('/etc/postgresql/9.5/main'), :if => os[:family] == 'ubuntu' do
  it { should be_directory }
end
describe file('/etc/postgresql/9.5/main/pg_hba.conf'), :if => os[:family] == 'ubuntu' do
  it { should be_file }
end
describe file('/usr/lib/postgresql/9.5/bin'), :if => os[:family] == 'ubuntu' do
  it { should be_directory }
end


describe file('/var/lib/pgsql'), :if => os[:family] == 'redhat' do
  it { should be_directory }
end
describe file('/var/lib/pgsql/data/pg_hba.conf'), :if => os[:family] == 'redhat' do
  it { should be_file }
end

