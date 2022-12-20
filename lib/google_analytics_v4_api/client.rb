# frozen_string_literal: true

require 'json'
require "net/http"
require "uri"

module GoogleAnalyticsV4Api
  class Client

    BASE_URL = "https://analyticsadmin.googleapis.com/v1beta"

    def initialize(access_token)
      @access_token = access_token
    end

    def accounts
      @accounts ||= GoogleAnalyticsV4Api::Account.parse_list get("/accounts").body
    end

    def account(account_name)
      accounts.find { |account| account.name == account_name }
    end

    def properties(account_name)
      @properties ||= GoogleAnalyticsV4Api::Property.parse_list get("/properties", { filter: "parent:#{account_name}"}).body
    end

    def property(property_name)
      unless @properties.nil?
        property = @properties.find { |property| property.name == property_name }
        return property unless property.nil?
      end

      GoogleAnalyticsV4Api::Property.parse get("/#{property_name}").body
    end

    private
    def get(path, params = {})
      url = "#{BASE_URL}#{path}"
      url += "?#{URI.encode_www_form params}" unless params.empty?
      uri = URI(url)

      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        request = Net::HTTP::Get.new uri
        request["Authorization"] = "Bearer #{@access_token}"
        request["Content-Type"] = "application/json"

        http.request request
      end
      raise GoogleAnalyticsV4Api::Error.new(response) unless response.is_a?(Net::HTTPSuccess)

      response
    end
  end
end