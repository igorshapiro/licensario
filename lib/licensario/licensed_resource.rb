##
# Licensed Resource Class
module Licensario
  class LicensedResource

    def initialize(xml)
      doc = Nokogiri::XML(xml)
    end

  end
end
