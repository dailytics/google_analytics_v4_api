# Google Analytics v4 API Ruby Gem
This is a simple wrapper to interact with the Google Analytics v4 API (currently in beta) with Ruby.
It's based on the [API guide](https://developers.google.com/analytics/devguides/config/admin/v1/rest/v1beta)

## Usage
Add this gem to your Gemfile:
```rb
gem 'google_analytics_v4_api'
```

You will need a way to get a user's valid (and fresh) token (I personally use the `gem omnioauth`).

The rest is still being defined.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dailytics/google_analytics_v4_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dailytics/google_analytics_v4_api/blob/main/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PlausibleApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dailytics/google_analytics_v4_api/blob/main/CODE_OF_CONDUCT.md).