##
# User Class
module Licensario
  class User < Licensario::Base

    attr_accessor :id, :external_user_id, :licensario_user_id, :email

    # Build the appropriate url for the API call
    def build_url(suffix)
      url = "/api/v1"
      if @external_user_id
        url += "/users/external/" + @external_user_id.to_s + suffix
      else
        url += "/users/" + @licensario_user_id.to_s + suffix
      end
      return url
    end
  
    # Ensure's that the User has the necessary License
    def ensure_has_license(payment_plan_id)
      begin
        res = @@api.do_request(:put, build_url('/licenses'), { 'paymentPlanId' => payment_plan_id })
        xml = res[:body]
        doc = Nokogiri::XML(xml)
        lnode = doc.xpath("//licenseCertificate")[0]     
        params = {
          id: lnode.attributes['licenseId'].value(),
          user_id: lnode.attributes['userId'].value(),
          payment_plan_id: lnode.attributes['paymentPlanId'].value(),
          issue_date_utc: lnode.attributes['issueDateUTC'].value(),
          expiration_date_utc: lnode.attributes['expirationDateUTC'].value(),
          is_trial: lnode.attributes['is_trial'].value()
        }
        license = Licensario::License.new(params)   
        return license
      rescue
        nil
      end
    end

    # Retrive this uses's licenses
    def get_licenses(feature_ids, payment_plan_ids = nil)
      licenses = []
      begin
        res = @@api.do_request(:get, build_url("/licenses"), { 'featureIds' => feature_ids, 'paymentPlanIds' => payment_plan_ids })
        xml = res[:body]
        doc = Nokogiri::XML(xml)
        doc.xpath("//userLicenses//licenseCertificate").each do |lnode|
          params = {
            id: lnode.attributes['licenseId'].value(),
            user_id: lnode.attributes['userId'].value(),
            payment_plan_id: lnode.attributes['paymentPlanId'].value(),
            issue_date_utc: lnode.attributes['issueDateUTC'].value(),
            expiration_date_utc: lnode.attributes['expirationDateUTC'].value(),
            is_trial: lnode.attributes['is_trial'].value()
          }
          license = Licensario::License.new(params)
          licenses << license
        end
      rescue
        nil      
      end
      return licenses
    end

    # Gets the amount available for a given Feature
    def get_available_feature_amount(feature_id, payment_plan_id = nil)
      amount = 0
      begin
        res = @@api.do_request(:get, build_url("/features/#{feature_id}/alloc"), { 'paymentPlanId' => payment_plan_id })
        amount = JSON.parse(res[:body])['available'].to_f
      rescue
        nil
      end
      return amount
    end

    # Increment a given Feature usage
    def increment_feature_usage(amount, feature_id, payment_plan_id = nil)
      begin
        res = @@api.do_request(:post, build_url("/features/#{feature_id}/alloc"), { 'amount' => amount.to_s, 'paymentPlanId' => payment_plan_id })
        return res[:status] == 200
      rescue
        nil
      end
    end

    def create_license(payment_plan_id)
    end
    
  end
end
