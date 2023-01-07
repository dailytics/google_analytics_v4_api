# frozen_string_literal: true

require "net/http"
require "uri"

module GoogleAnalyticsV4Api
  class Request

    ADMIN_URL = "https://analyticsadmin.googleapis.com/v1beta"
    DATA_URL = "https://analyticsdata.googleapis.com/v1beta/properties/{{PROPERTY_ID}}:runReport"

    def self.get(access_token:, url: nil, path:, params: {})
      url = "#{url || ADMIN_URL}#{path}"
      url += "?#{URI.encode_www_form params}" unless params.empty?
      uri = URI(url)

      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        request = Net::HTTP::Get.new uri
        request["Authorization"] = "Bearer #{access_token}"
        request["Content-Type"] = "application/json"

        http.request request
      end
      raise GoogleAnalyticsV4Api::Error.new(response) unless response.is_a?(Net::HTTPSuccess)

      response
    end

    def self.post(access_token:, url: nil, path:, params: {})

    end

  end
end
