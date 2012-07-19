require 'spec_helper'

describe Licensario do

  it 'tests a common workflow' do
    user_params = {
      external_user_id: '1',
      email: 'some@user.net'
    }
    payment_plan_id = 'FREE_PLANca1b8f4ead'
    feature_id = 'MANAGE_TOD5533de505b'  
    user = Licensario::User.new(user_params)
    license = user.ensure_has_license(payment_plan_id)
    license.should_not be_nil
    licenses = user.get_licenses([feature_id],[payment_plan_id])   
    feature_amount = user.get_available_feature_amount(feature_id, payment_plan_id)
    user.increment_feature_usage(1, feature_id, payment_plan_id)
    new_feature_amount = user.get_available_feature_amount(feature_id, payment_plan_id)
    ( feature_amount - new_feature_amount ).should eq(1)
  end

  describe Licensario::User do
  end

  describe Licensario::License do
  end

  describe Licensario::LicensedResource do
  end

  describe Licensario::API do

    it 'checks the API heartbeat' do
    end
  
    it 'Ensures the existence of an external user' do
      res = Licensario::Base.api.ensure_external_user_exists('1', 'some@user.net')
      (res[:body] =~ /^\s*$/).should eq(0)
      res[:status].should eq(200)
    end
  
  end

end
