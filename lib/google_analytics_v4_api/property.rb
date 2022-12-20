# frozen_string_literal: true

require 'json'

module GoogleAnalyticsV4Api
  class Property
    attr_accessor :name, :propertyType, :createTime, :updateTime, :parent, :displayName, :industryCategory, :timeZone, :currencyCode, :serviceLevel, :deleteTime, :expireTime, :account

    def initialize(attributes = {})
      attributes.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    def self.parse_list(body)
      JSON.parse(body)["properties"].map do |attrs|
        GoogleAnalyticsV4Api::Property.new(attrs)
      end
    end

    def self.parse(body)
      GoogleAnalyticsV4Api::Property.new(JSON.parse(body))
    end

  end
end