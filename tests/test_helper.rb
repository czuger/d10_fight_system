require 'simplecov'
SimpleCov.start

# $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'hazard'

require 'minitest/autorun'
require 'mocha/minitest'
require 'pp'

require_relative '../lib/core/damages/damages_handler'
require_relative '../lib/core/check2d10'