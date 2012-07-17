require 'spec_helper'

describe Licensario do

  before(:each) do
    key = 'db886331e9105fc19dc9fd6df2caebab9f112c3c81877ea3a3bfcfe3076aa77d'
    secret = '5545981d57eb3244e857d561946f4ee312023000da1b9f6b86ab017ee48e5c2d'
    @api = Licensario::API.new(key,secret)
  end

  it 'should initialize an API driver' do
    api = Licensario::API.new('key','secret')
    api.key.should eq('key')
    api.secret.should eq('secret')
  end

  it 'checks the API heartbeat' do
    pending 'Implement in the Server'
    #status = @api.check_server_status
    #status.should eq('OK')
  end

  it 'Ensures the existence of an external user' do
    res = @api.ensure_external_user_exists('1', 'some@user.net')
    (res['body'] =~ /^\s*$/).should eq(0)
    res['status'].should eq('200')

  end

  it 'Retrieves the User Licenses' do
  end

  it 'Checks if the Resource is available' do
  end

end
