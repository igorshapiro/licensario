##
# Licensario Low Level communication API
module Licensario
  class API
    
    attr_reader :key, :secret, :base_url

    def initialize(key, secret, base_url = 'users.licensario.com', use_ssl = true)
      @key, @secret, @base_url, @use_ssl = key, secret, base_url, use_ssl
    end

    # Forms the appropriate request URL
    def request_url(url)
      (@use_ssl ? 'https' : 'http') + '://' + @base_url + url
    end

    # Executes the actual request with the API server and processes the response
    def do_request(method, resource, params = {})
      begin
        uri = URI.parse(request_url(resource))
        uri.query = URI.encode_www_form(params) if !params.empty? and method == :get
        puts "#{method} - #{uri.request_uri}"
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = @use_ssl
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE if @use_ssl
        case method
        when :post
          req_class = Net::HTTP::Post
        when :get
          req_class = Net::HTTP::Get
        when :put
          req_class = Net::HTTP::Put
        when :delete
          req_class = Net::HTTP::Delete
        end
        request = req_class.new(uri.request_uri)
        request.content_type = "application/x-www-form-urlencoded"
        request['ISV_API_KEY'] = @key
        request['ISV_API_SECRET'] = @secret
        request['LCNS_DISABLE_SIGN'] = 'true'
        request.set_form_data(params) if !params.empty? and [:post,:put].include?(method)
        response = http.request(request)
        return { body: response.body, status: response.code.to_i }
      rescue
        return { body: nil, status: nil }
      end
    end

    # Checks the API Server Status - TODO
    def check_server_status
      status = do_request(:get, '/status')
      return 'OK'
    end

    # Gets an External User
    def get_external_user(user_id, user_email)
      res = ensure_external_user_exists(user_id, user_email)
      params = res[:body]
      user = Licensario::User.new(params)
      user.api = self
      return user
    end

    # Ensures the existence of an external user 
    def ensure_external_user_exists(external_user_id, email)
      do_request(:put, "/api/v1/users/external/#{external_user_id}", { email: email })
    end

    # Checks the Resource Availability
    def resource_available?(user_id, external_user_id, resource_id, amount, operation)
      url = "/api/userresources/available?userId=" + user_id
      url += "&externalUserId=" + external_user_id
      url += "&resourceId=" + resource_id
      url += "&amount=" + amount
      url += "&operation=" + operation
      do_request(:get, url)
    end

    # Checks if Resource can be incremented
    def can_increment_resource?(user_id, external_user_id, resource_id, amount)
      res = resource_available?(user_id, external_user_id, resource_id, amount, "increment")
      return (res[:body] =~ /yes/ or res[:body] =~ /true/) != nil
    end

    # Checks if Resource can be setted
    def can_set_resource?(user_id, external_user_id, resource_id, amount)
      res = resource_available?(user_id, external_user_id, resource_id, amount, "set")
      return (res[:body] =~ /yes/ or res[:body] =~ /true/) != nil
    end

  end
end
