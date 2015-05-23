module Elos::Repository::Adapter::Elos::Model::Destroyable
  extend ActiveSupport::Concern

  included do
    cattr_writer :physically_destroy

    attr_accessor :destroyed

    define_model_callbacks :destroy

    before_new -> { self.destroyed = false; true }

    self.physically_destroy = true
  end

  class_methods do
    def physically_destroy?
      physically_destroy
    end

    def physically_destroy(flag = nil)
      if flag.nil?
        self.class_variable_get(:@@physically_destroy)
      else
        self.physically_destroy = flag
      end
    end
  end

  def destroyed?
    destroyed
  end

  def destroy
    run_callbacks :destroy do
      if self.class.physically_destroy?
        self.class.index(self, unindex: true)
      else
        self.class.index(self, destroy: true)
      end
      self.destroyed = true
    end
  end
end
