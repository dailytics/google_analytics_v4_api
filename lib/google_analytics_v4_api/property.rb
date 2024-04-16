# frozen_string_literal: true

require "json"

module GoogleAnalyticsV4Api
  class Property
    attr_accessor :name, :propertyType, :createTime, :updateTime, :parent, :displayName, :industryCategory, :timeZone, :currencyCode, :serviceLevel, :deleteTime, :expireTime

    def initialize(client, attributes = {})
      @client = client
      attributes.each do |k, v|
        send("#{k}=", v) if self.respond_to?("#{k}=")
      end
    end

    def account
      @client.account(parent)
    end

    def run_report(report)
      response = Request.post(access_token: @client.access_token, path: "/#{name}:runReport", payload: report.to_json)
      ReportResponse.new(response)
    end

    def self.parse_list(client, body)
      parsed_body = JSON.parse(body)
      return [] if parsed_body["properties"].nil?

      parsed_body["properties"].map do |attrs|
        GoogleAnalyticsV4Api::Property.new(client, attrs)
      end
    end

    def self.parse(client, body)
      GoogleAnalyticsV4Api::Property.new(client, JSON.parse(body))
    end
  end
end
