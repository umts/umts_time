# frozen_string_literal: true

require File.expand_path 'lib/umts_time/version', __dir__

Gem::Specification.new do |s|
  s.name     = 'umts_time'
  s.version  = UMTSTime::VERSION
  s.summary  = 'Rails time library for use with UMTS apps.'

  s.author   = 'umts'
  s.email    = 'transit-it@admin.umass.edu'
  s.homepage = 'https://github.com/umts/umts_time'
  s.license  = 'MIT'

  s.files         = Dir['lib/**/*']
  s.require_paths = 'lib'

  s.add_dependency 'rails', '>= 5.1'
end
