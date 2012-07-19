##
# Basic Resource Class
module Licensario
  class BasicResource

    def initialize(attributes = {})
      @attributes = attributes
      @attributes.each do |k,v|
        self.send(k.to_s + '=',v)
      end
    end

  end
end
