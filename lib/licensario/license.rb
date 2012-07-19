##
# License Class
module Licensario
  class License < Licensario::Base
    attr_accessor :id, :user_id, :payment_plan_id, :issue_date_utc, :expiration_date_utc, :is_trial, :included_features, :included_resources

    def initialize(attributes = {})
      if attributes[:xml_node] or attributes[:xml]
        xml_node = attributes[:xml_node] ? attributes[:xml_node] : Nokogiri::XML(attributes[:xml]).xpath("//licenseCertificate")[0]
        xml_attrs = xml_node.attributes
        {
          id: 'licenseId',
          user_id: 'userId',
          payment_plan_id: 'paymentPlanId',
          issue_date_utc: 'issueDateUTC',
          expiration_date_utc: 'expirationDateUTC',
          is_trial: 'is_trial'
        }.each do |k,v|
          attributes[k] = xml_attrs[v] ? xml_attrs[v].value : nil
        end
        attributes[:included_resources] = []
        xml_node.xpath("//resources/resource").each do |node|
          resource = Licensario::LicensedResource.new(xml_node: node)
          attributes[:included_resources] << resource
        end
        attributes[:included_features] = []
        xml_node.xpath("//features/feature").each do |node|
          feature = Licensario::LicensedFeature.new(xml_node: node)
          attributes[:included_features] << feature
        end
        attributes.delete(:xml_node)
        attributes.delete(:xml)
      end
      attributes[:is_trial] = 'false' if !attributes.has_key?(:is_trial)
      super(attributes)
    end

    # Redefine the issue_date_utc setter to parse the date and time
    def issue_date_utc=(date_time_string)
      @issue_date_utc = DateTime.strptime(date_time_string, Licensario::Base.date_format) if date_time_string
    end

    # Redefine the expiration_date_utc setter to parse the date and time
    def expiration_date_utc=(date_time_string)
      @expiration_date_utc = DateTime.strptime(date_time_string, Licensario::Base.date_format) if date_time_string
    end

    def to_s
      s = %Q{}
      s += "licenseId: #{id}\n"
      s += "isTrial: #{is_trial}\n"
      s += "userId: #{user_id}\n"
      s += "issued(UTC): #{issue_date_utc}\n"
      s += "expires(UTC): #{expiration_date_utc}\n"
      s += "includedFeatures: #{included_features}\n"
      s += "includedResources: #{included_resources}\n"
      return s
    end

  end
end
