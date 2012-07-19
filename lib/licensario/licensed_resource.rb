##
# Licensed Resource Class
module Licensario
  class LicensedResource < Licensario::Base

    attr_accessor :id, :total_amount, :amount_used, :type

    def initialize(attributes = {})
      if attributes[:xml_node] or attributes[:xml]
        xml_node = attributes[:xml_node] ? attributes[:xml_node] : Nokogiri::XML(attributes[:xml]).xpath("//resource")[0]
        xml_attrs = xml_node.attributes
        {
          id: 'resourceId',
          total_amount: 'totalAmount',
          amount_used: 'amountUsed',
          type: 'type'
        }.each do |k,v|
          attributes[k] = xml_attrs[v] ? xml_attrs[v].value : nil
        end      
      end
      super(attributes)
    end

  end
end
