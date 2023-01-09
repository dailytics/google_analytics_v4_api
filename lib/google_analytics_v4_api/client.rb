# frozen_string_literal: true

module GoogleAnalyticsV4Api
  class Client

    attr_accessor :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def accounts
      @accounts ||= GoogleAnalyticsV4Api::Account.parse_list(self, get("/accounts"))
    end

    def account(account_name)
      accounts.find { |account| account.name == account_name }
    end

    def properties(account_name)
      @properties ||= Hash.new do |h, key|
        h[key] = GoogleAnalyticsV4Api::Property.parse_list(self, get("/properties", { filter: "parent:#{key}"}))
      end
      @properties[account_name]
    end

    def property(property_name)
      unless @properties.nil?
        property = @properties.find { |property| property.name == property_name }
        return property unless property.nil?
      end

      GoogleAnalyticsV4Api::Property.parse(self, get("/#{property_name}"))
    end

    private
    def get(path, params = {})
      Request.get(access_token: @access_token, path: path, params: params).body
    end

  end
end