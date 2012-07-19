##
# User Class
module Licensario
  class User #< Licensario::BasicResource

    attr_accessor :api, :external_user_id, :licensario_user_id, :email

    def build_url(suffix)
      url = "/api/v1"
      if @external_user_id
        url += "/users/external" + @external_user_id.to_s + suffix
      else
        url += "/users/external" + @licensario_user_id.to_s + suffix
      end
      return url
    end
  
    def ensure_has_license(payment_plan_id)
      @api.do_request(:put, build_url('/licenses'), { 'paymentPlanId' => payment_plan_id })
    end

    def get_licenses(feature_ids = nil, payment_plan_ids = nil)
    end

    def get_available_feature_amount(feature_id, payment_plan_id = nil)
    end

    def increment_feature_usage(amount, feature_ids, payment_plan_id = nil)
    end

    def create_license(payment_plan_id)
    end
    
  end
end
