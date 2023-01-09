# frozen_string_literal: true

require 'json'
require 'date'

module GoogleAnalyticsV4Api
  class Report
    attr_accessor :date_ranges, :dimensions, :metrics, :dimension_filter

    def initialize(start_date: nil, end_date: nil, dimensions: [], metrics: [], dimension_filter: {})
      @date_ranges = [{ "startDate": start_date || (Date.today - 30), "endDate": end_date || Date.today }]
      @dimensions = dimensions.map { |dimension| { "name": dimension } }
      @metrics = metrics.map { |metric| { "name": metric } }
      @dimension_filter = dimension_filter
    end

    def to_json
      {
        "dateRanges": @date_ranges,
        "dimensions": @dimensions,
        "metrics": @metrics,
        "dimensionFilter": @dimension_filter
      }.to_json
    end
  end
end