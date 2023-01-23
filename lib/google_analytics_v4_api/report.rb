# frozen_string_literal: true

require 'json'
require 'date'

module GoogleAnalyticsV4Api
  class Report
    attr_accessor :date_ranges, :dimensions, :metrics, :dimension_filter

    def initialize(start_date: nil, end_date: nil, dimensions: [], metrics: [], dimension_filter: {}, limit: 20, offset: 0)
      @date_ranges = [{ "startDate": start_date || (Date.today - 30), "endDate": end_date || Date.today }]
      @dimensions  = dimensions.map { |dimension| { "name": dimension } }
      @metrics = metrics.map { |metric| { "name": metric } }
      @dimension_filter = dimension_filter
      @limit = limit
      @offset = offset
    end

    def to_json
      output = {}
      output[:dateRanges] = @date_ranges
      output[:dimensions] = @dimensions if !@dimensions.nil? && @dimensions.any?
      output[:metrics] = @metrics if !@metrics.nil? && @metrics.any?
      output[:dimensionFilter] = @dimension_filter if !@dimension_filter.nil? && @dimension_filter.any?
      output[:limit] = @limit unless @limit.nil?
      output[:offset] = @offset unless @offset.nil?
      output.to_json
    end
  end
end