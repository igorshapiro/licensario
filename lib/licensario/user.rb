##
# User Class
module Licensario
  class User

    def initialize(api, external_user_id = nil, licensario_user_id = nil, email = nil )
    end

    def build_url(suffix)
    end
  
    def ensure_has_license(payment_plan_id)
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
