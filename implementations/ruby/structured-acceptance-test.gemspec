require 'rake'
Gem::Specification.new do |s|
  s.name        = 'structured-acceptance-test'
  s.version     = '0.0.6'
  s.date        = '2017-04-12'
  s.summary     = 'Structured acceptance test'
  s.description = 'Structured acceptance test data structure gem'
  s.authors     = ['William Entriken', 'Ilia Grabko']
  s.email       = 'github.com@phor.net'
  s.files       = FileList['lib/*.rb']
  s.homepage    = 'https://github.com/fulldecent/structured-acceptance-test'
  s.license     = 'MIT'

  s.add_runtime_dependency 'safe-enum', '>= 0.3.0'
  s.add_runtime_dependency 'json-schema', '>= 2.8.0'
  s.add_runtime_dependency 'colorize', '>= 0.8.1'
end
