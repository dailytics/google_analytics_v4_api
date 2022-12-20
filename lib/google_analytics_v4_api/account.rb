# frozen_string_literal: true

require 'json'

module GoogleAnalyticsV4Api
  class Account
    attr_accessor :name, :createTime, :updateTime, :displayName, :regionCode

    def initialize(attributes = {})
      attributes.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    def properties

    end

    def self.parse_list(body)
      JSON.parse(body)["accounts"].map do |attrs|
        GoogleAnalyticsV4Api::Account.new(attrs)
      end
    end
  end
end