module Elos::Repository::Adapter::ActiveRecord
  extend ActiveSupport::Concern

  include Elos::Repository::Publishable
  include Elos::Repository::Adapter::ActiveRecord::Scanable
end
