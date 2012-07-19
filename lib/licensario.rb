# encoding: utf-8

require "licensario/version"
require 'net/http'
require 'nokogiri'
require 'uri'
require 'json'
require 'date'

LICENSARIO_PATH = File.dirname(__FILE__) + '/licensario/'

['api', 'base', 'user','license', 'licensed_resource', 'licensed_feature'].each do |req|
  require LICENSARIO_PATH + req
end
