# frozen_string_literal: true

require 'json'

module GoogleAnalyticsV4Api
  class Property
    attr_accessor :name, :propertyType, :createTime, :updateTime, :parent, :displayName, :industryCategory, :timeZone, :currencyCode, :serviceLevel, :deleteTime, :expireTime, :account

    def initialize(client, attributes = {})
      @client = client
      attributes.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    def account
      @client.account(parent)
    end

    def self.parse_list(client, body)
      JSON.parse(body)["properties"].map do |attrs|
        GoogleAnalyticsV4Api::Property.new(client, attrs)
      end
    end

    def self.parse(client, body)
      GoogleAnalyticsV4Api::Property.new(client, JSON.parse(body))
    end
  end
end