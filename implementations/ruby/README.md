# Ruby Gem

This data structure allows you to store STAT information in memory.

This Gem also provides incremental printing so that you can output each finding as it is made.

## Usage

In your Ruby project, add this to your Gemfile:

```
source 'http://rubygems.org'

gem 'structured-acceptance-test'
```

See an example program that outputs findings at https://github.com/fulldecent/structured-acceptance-test/blob/master/tools/example-process/example-process.rb

## Contributing

Publish a new version to rubygems.org:

```sh
rm structured-acceptance-test-*.gem
gem build structured-acceptance-test.gemspec
gem push structured-acceptance-test-*.gem
```
