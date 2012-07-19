##
# License Class
module Licensario
  class License < Licensario::Base
    attr_accessor :id, :user_id, :payment_plan_id, :issue_date_utc, :expiration_date_utc, :is_trial
  end
end
