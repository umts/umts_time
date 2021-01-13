# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name     = 'umts_time'
  s.version  = '0.0'
  s.summary  = 'Rails time library for use with UMTS apps.'

  s.author = 'umts'
  s.email = 'transit-it@admin.umass.edu'
  s.homepage = 'https://github.com/umts/umts_time'
  s.license  = 'MIT'

  s.require_paths = 'lib'
  s.files = Dir['lib/**/*']
  s.add_dependency 'rails', '>= 5.1'
end
