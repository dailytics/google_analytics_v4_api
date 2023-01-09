# frozen_string_literal: true

require 'json'
require 'date'

module GoogleAnalyticsV4Api
  class ReportResponse

    def initialize(body)
      @raw_body = JSON.parse body
      @raw_dimension_headers = @raw_body["dimensionHeaders"]
      @dimension_headers = @raw_dimension_headers.map { |header| header["name"] }
      @raw_metric_headers = @raw_body["metricHeaders"]
      @metric_headers = @raw_metric_headers.map { |header| header["name"] }
      @rows = @raw_body["rows"]
      @row_cont = @raw_body["rowCount"]
      @metadata = @raw_body["metadata"]
      @kind = @raw_body["kind"]
    end

    def parsed_rows
      @rows.map do |row|
        ReportResponseRow.new(row, @raw_dimension_headers, @raw_metric_headers)
      end
    end

  end
end