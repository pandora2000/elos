$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'active_record'
require 'database_cleaner'
require 'elasticsearch'
require 'elos'

require_relative 'support/active_record'
require_relative 'support/elos'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
