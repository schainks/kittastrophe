# Kittastrophe

This Ruby Gem is a CLI client for Adobe's original [TypeKit API](https://typekit.com/docs/api/v1/:format/kits).

It can be used both as a gem or as it's intended CLI tool.

## Installation and dependencies

This gem assumes you have `liburl` installed.  

Mac OS installation of `libcurl` can be handled vie installing [Homebrew](https://brew.sh/), and then running `$ brew install curl`.

Most modern Linuxes ensure libcurl is installed or make it very easy to do so.

Install `kittastrophe` via

    $ gem install kittastrophe

Or add this line to your application's Gemfile:

```ruby
gem 'kittastrophe'
```

And then execute:

    $ bundle

## TODO

- [ ] Prettier printing of output
- [ ] Better encapsulation of functionality
- [ ] Use proper exit codes for client
- [ ] Refactor test suite to better encapsulate stubbed API responses 

## Usage

```bash
Options:
    -c, --configure              Configure your TypeKit API key
                                    so you don't have to always remember it.
    -l, --list                   List kits owned by the authenticating user.
    -s, --show ID                Show information for kit with the given ID
    -h, --help                   Shows help
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/schainker/kittastrophe.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
