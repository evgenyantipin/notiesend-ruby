require 'faraday'
require 'forwardable'
require 'json'
require 'ostruct'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

require 'notisend/blank_query'
require 'notisend/client'
require 'notisend/collection'
require 'notisend/list'
require 'notisend/message'
require 'notisend/parameter'
require 'notisend/recipient'
require 'notisend/recipients_import'
require 'notisend/response'
require 'notisend/version'

# Base namespace
module Notisend
  using BlankQuery

  class << self
    attr_accessor :api_token

    def configure
      yield(self) if block_given?
    end

    def client
      @client ||= begin
                    token = ENV['NOTISEND_API_TOKEN'] || api_token

                    raise Error, 'Notisend api token is blank' if token.blank?

                    Client.new(token)
                  end
    end
  end
end
