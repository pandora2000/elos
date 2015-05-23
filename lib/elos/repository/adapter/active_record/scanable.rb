module Elos::Repository::Adapter::ActiveRecord::Scanable
  extend ActiveSupport::Concern

  class_methods do
    def scan(batch_size = nil, &block)
      find_each(batch_size: batch_size) do |record|
        block.(record)
      end
    end
  end
end
