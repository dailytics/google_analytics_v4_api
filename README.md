# Google Analytics v4 API Ruby Gem
This is a simple wrapper to interact with the Google Analytics v4 API (currently in beta) with Ruby.
It's based on the [Admin API guide](https://developers.google.com/analytics/devguides/config/admin/v1/rest) and the
[Reports API guide](https://developers.google.com/analytics/devguides/reporting/data/v1/basics?authuser=1#report_response)

## Usage
Add this gem to your Gemfile:
```rb
gem 'google_analytics_v4_api'
```

You will need a way to get a user's valid (and fresh) token (I personally use the `gem omnioauth`), and then:

### Management API
```rb
client = GoogleAnalyticsV4Api::Client.new(token)
# List all the accounts
accounts = client.accounts
# Or get one particular account
account = client.account("account/24696xxx")

# List all the properties for a particular account
properties = client.properties("accounts/24596xxx")
# Or get one particular property
property = client.property("properties/33783xxx")

# Or simply call the properties for an Account object
properties = account.properties
# Or one particular property
property = account.property("properties/33783xxx")
```

### Data API
```rb
filter = {
  "andGroup": {
    "expressions": [
      {
        "filter": {
          "fieldName": "countryId",
          "stringFilter": {
            "value": "CL"
          }
        }
      },
      {
        "filter": {
          "fieldName": "pagePath",
          "stringFilter": {
            "matchType": "CONTAINS",
            "value": "events",
            "caseSensitive": false
          }
        }
      }
    ]
  }
}
report = GoogleAnalyticsV4Api::Report.new(
          dimensions: ['pagePath', 'countryId'],
          metrics: ['sessions', 'screenPageViews'],
          dimension_filter: filter,
          start_date: Date.today - 30, #optional, 30 days ago by default
          end_date: Date.today - 1) #optional, today by default

response = property.run_report(report)

# Get raw data from the response
response.raw_dimension_headers
=> [{"name"=>"pagePath"}, {"name"=>"countryId"}]
response.raw_metric_headers
=> [{"name"=>"sessions", "type"=>"TYPE_INTEGER"}, {"name"=>"screenPageViews", "type"=>"TYPE_INTEGER"}]
response.rows.first
=> {"dimensionValues"=>[{"value"=>"/events"}, {"value"=>"CL"}], "metricValues"=>[{"value"=>"58"}, {"value"=>"78"}]}

# Or get a simplified version of the response
response.dimension_headers
=> ["pagePath", "countryId"]
response.metric_headers
=> ["sessions", "screenPageViews"]
response.parsed_rows.first.data
=> {"pagePath"=>"/events", "countryId"=>"CL", "sessions"=>58, "screenPageViews"=>78}

```
Dimensions and Metrics are available [here](https://developers.google.com/analytics/devguides/reporting/data/v1/api-schema)
Information about Filters is available [here](https://developers.google.com/analytics/devguides/reporting/data/v1/basics#dimension_filters)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dailytics/google_analytics_v4_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dailytics/google_analytics_v4_api/blob/main/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PlausibleApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dailytics/google_analytics_v4_api/blob/main/CODE_OF_CONDUCT.md).