require 'google_analytics_v4_api/version'

module GoogleAnalyticsV4Api
  autoload :Client, "google_analytics_v4_api/client"
  autoload :Account, "google_analytics_v4_api/account"
  autoload :Property, "google_analytics_v4_api/property"
  autoload :Request, "google_analytics_v4_api/request"
  autoload :Report, "google_analytics_v4_api/report"
  autoload :ReportResponse, "google_analytics_v4_api/report_response"
  autoload :ReportResponseRow, "google_analytics_v4_api/report_response_row"
  autoload :Error, "google_analytics_v4_api/error"
end