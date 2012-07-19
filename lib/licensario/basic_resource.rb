##
# Basic Resource Class
module Licensario
  class Base

    @@api = nil

    def initialize(attributes = {})
      @attributes = attributes
      @attributes.each do |k,v|
        self.send(k.to_s + '=',v)
      end
    end

    def establish_connection(key, secret, base_url = 'users.licensario.com', use_ssl = true)
      @@api = Licensario::API.new(key, secret, base_url, use_ssl)
    end

  end
end
