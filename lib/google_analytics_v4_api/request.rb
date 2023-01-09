# frozen_string_literal: true

require "net/http"
require "uri"

module GoogleAnalyticsV4Api
  class Request

    ADMIN_URL = "https://analyticsadmin.googleapis.com/v1beta"
    DATA_URL = "https://analyticsdata.googleapis.com/v1beta"

    def self.get(access_token:, url: ADMIN_URL, path:, params: {})
      url = "#{url}#{path}"
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

    def self.post(access_token:, url: DATA_URL, path:, payload: nil)
      url = URI("#{url}#{path}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Bearer #{access_token}"
      request["Content-Type"] = "application/javascript"
      request.body = payload

      response = https.request(request)
      response.read_body
    end

  end
end
