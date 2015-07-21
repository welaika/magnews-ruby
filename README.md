# Magnews

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/magnews`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'magnews'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install magnews

## Usage

Create a configuration file like this:

```ruby
Magnews.configure do |config|
  config.auth_token = Rails.application.secrets.magnews_token
  config.iddatabase = Rails.configuration.x.magnews.database_id
  config.logger = Rails.configuration.x.newsletter.logger
end
```

### Contact create

To create a contact use create! method with subscription parameters (more infos [Magnews Rest API subscribe contact](http://support.magnews.it/en/ws/restcontacts.html#Subscribe_contact))

```
Magnews::Contact.create!(subscription_params)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/magnews. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

