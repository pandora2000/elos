module Elos::Repository::Adapter::Elos::Model::Persistable
  extend ActiveSupport::Concern

  included do
    attr_accessor :persisted

    define_model_callbacks :save, :create, :update

    before_new -> { self.persisted = !!@_attrs.delete(:_persisted); true }
  end

  class_methods do
    def create(attrs = {})
      obj = new(attrs)
      obj.save
      obj
    end

    def create!(attrs = {})
      obj = new(attrs)
      obj.save!
      obj
    end
  end

  def persisted?
    persisted
  end

  def save
    _save
  end

  def save!
    _save(raise_error: true)
  end

  def update(attrs = {})
    assign_attributes(attrs)
    save
  end

  def update!(attrs = {})
    assign_attributes(attrs)
    save!
  end

  private

  def _save(raise_error: false, callback: true)
    return false unless raise_error ? validate! : valid?
    optionally_run_callbacks(:save, callback: callback) do
      if persisted?
        optionally_run_callbacks(:update, callback: callback) do
          _save_core
        end
      else
        optionally_run_callbacks(:create, callback: callback) do
          _save_core
          self.persisted = true
        end
      end
    end
    true
  end

  def optionally_run_callbacks(method, callback: true, &block)
    if callback
      run_callbacks(method, &block)
    else
      block.()
    end
  end

  def _save_core
    r = reindex
    self.id ||= r
  end
end
