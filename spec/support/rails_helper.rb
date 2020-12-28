# frozen_string_literal: true

ENV['RAILS_ENV']  = 'test'
ENV['RAILS_ROOT'] = File.expand_path File.join(File.dirname(__FILE__), 'rails_dummy')

require 'rails_dummy/config/environment'
require 'rspec/rails'
