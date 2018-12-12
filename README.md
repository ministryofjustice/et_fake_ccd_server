# Et Fake Ccd Server

This server replicates some of Core Case Data (CCD) API functionality for test purposes

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'et_fake_ccd_server'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install et_fake_ccd_server

## Usage

### Using Webmock (Internal to your test suite)

```ruby

  stub_request(:any, /fakeservice\.com/).to_rack(EtFakeCcdServer::Server)

```

This will mean that any requests to fakeservice.com will go to the fake ccd server


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/et_fake_ccd_server.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
