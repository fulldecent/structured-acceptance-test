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

## Atom linter

Your process will produce output that can also be consumed by Atom. See our example atom process in the `tools/` folder.

![stat](https://cloud.githubusercontent.com/assets/11000048/23030871/20e28fba-f480-11e6-96d6-23c5e2d5afd2.gif)

## Contributing

Publish a new version to rubygems.org:

```sh
rm structured-acceptance-test-*.gem
gem build structured-acceptance-test.gemspec
gem push structured-acceptance-test-*.gem
```
