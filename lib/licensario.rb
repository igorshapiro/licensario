require "licensario/version"
require 'net/http'
require 'nokogiri'
require 'uri'
LICENSARIO_PATH = File.dirname(__FILE__) + '/licensario/'

['api','user','license', 'licensed_resource'].each do |req|
  require LICENSARIO_PATH + req
end
