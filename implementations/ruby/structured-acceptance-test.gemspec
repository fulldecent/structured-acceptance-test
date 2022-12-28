Gem::Specification.new do |s|
  s.name        = 'structured-acceptance-test'
  s.version     = '0.0.8'
  s.summary     = 'Structured acceptance test'
  s.description = 'Structured acceptance test data structure gem'
  s.authors     = ['William Entriken', 'Ilia Grabko']
  s.email       = 'github.com@phor.net'
  s.files       = [
    'lib/structured-acceptance-test.rb',
    'lib/category.rb',
    'lib/detail.rb',
    'lib/duplicate_element_exception.rb',
    'lib/finding.rb',
    'lib/fix.rb',
    'lib/index_out_of_bound_exception.rb',
    'lib/JSONable.rb',
    'lib/location.rb',
    'lib/process.rb',
    'lib/repeatability.rb',
    'lib/type_exception.rb',
  ]
  s.homepage    = 'https://github.com/fulldecent/structured-acceptance-test'
  s.license     = 'MIT'

  s.add_runtime_dependency 'colorize', '~> 0.8', '>= 0.8.1'
end
