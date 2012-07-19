##
# Licensed Feature Class
module Licensario
  class LicensedFeature < Licensario::Base

    attr_accessor :id, :total_amount, :amount_used

    def initialize(attributes = {})
      if attributes[:xml_node] or attributes[:xml]
        xml_node = attributes[:xml_node] ? attributes[:xml_node] : Nokogiri::XML(attributes[:xml]).xpath("//feature")[0]
        xml_attrs = xml_node.attributes
        {
          id: 'id',
          total_amount: 'totalAmount',
          amount_used: 'amountUsed'
        }.each do |k,v|
          attributes[k] = xml_attrs[v] ? xml_attrs[v].value : nil
        end  
        attributes.delete(:xml_node)
        attributes.delete(:xml)    
      end
      super(attributes)
    end

  end
end
