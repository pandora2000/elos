Dir[File.expand_path('../../sample_app/**/*\.rb', __FILE__).to_s].each { |f| require(f) }

RSpec.configure do |config|
  config.extend Elos::SpecHelper
end
