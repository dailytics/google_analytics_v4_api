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
      get("/accounts")
    end

    private
    def get(path, params = {})
      uri = URI("#{BASE_URL}#{path}")

      Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        request = Net::HTTP::Get.new uri
        request["Authorization"] = "Bearer #{@access_token}"
        request["Content-Type"] = "application/json"

        response = http.request request # Net::HTTPResponse object
      end
  end
end