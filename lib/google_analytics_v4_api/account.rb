# frozen_string_literal: true

require 'json'

module GoogleAnalyticsV4Api
  class Account
    attr_accessor :name, :createTime, :updateTime, :displayName, :regionCode

    def initialize(client, attributes = {})
      @client = client
      attributes.each do |k, v|
        self.send("#{k}=", v) if self.respond_to?("#{k}=")
      end
    end

    def properties
      @client.properties(name)
    end

    def property(property_name)
      @client.property(property_name)
    end

    def self.parse_list(client, body)
      parsed_body = JSON.parse(body)
      return [] if parsed_body["accounts"].nil?

      parsed_body["accounts"].map do |attrs|
        GoogleAnalyticsV4Api::Account.new(client, attrs)
      end
    end
  end
end