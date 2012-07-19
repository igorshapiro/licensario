# encoding: utf-8

##
# Base Licensario Class, responsible for low-level communications and centralized API connection managament

module Licensario
  class Base

    @@api = nil

    def initialize(attributes = {})
      @attributes = attributes
      @attributes.each do |k,v|
        self.send(k.to_s + '=',v)
      end
    end

    # Establish a common connection for all Licensario operations
    def self.establish_connection(options = {})
      @options = {
        base_url: 'users.licensario.com',
        use_ssl: true
      }.merge(options)
      @@api = Licensario::API.new(@options[:key], @options[:secret], @options[:base_url], @options[:use_ssl])
    end

    def self.api
      @@api
    end

  end
end
