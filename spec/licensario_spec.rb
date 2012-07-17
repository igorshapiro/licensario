require 'spec_helper'

describe Licensario do

  describe Licensario::User do
  end

  describe Licensario::License do
  end

  describe Licensario::LicensedResource do
  end

  describe Licensario::API do
   let(:api) do
     key = 'db886331e9105fc19dc9fd6df2caebab9f112c3c81877ea3a3bfcfe3076aa77d'
     secret = '5545981d57eb3244e857d561946f4ee312023000da1b9f6b86ab017ee48e5c2d'
     Licensario::API.new(key,secret)
   end

   # before(:each) do
 
    it 'checks the API heartbeat' do
    end
  
    it 'Ensures the existence of an external user' do
      res = api.ensure_external_user_exists('1', 'some@user.net')
      (res['body'] =~ /^\s*$/).should eq(0)
      res['status'].should eq('200')
    end
  
    it 'Retrieves the User Licenses' do
    end
  
    it 'Checks if the Resource is available' do
    end
  end

end
