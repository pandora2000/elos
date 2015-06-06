module Elos::SpecHelper
  ::RSpec.configure do |config|
    config.prepend_before(:suite) do
      Elos.index_classes.each do |klass|
        %i(find search).each do |method|
          klass.singleton_class.send(:alias_method, "_#{method}".to_sym, method)
          klass.define_singleton_method(method) do |*args|
            klass.refresh
            klass.send("_#{method}", *args)
          end
        end
      end
    end
    config.prepend_before do
      Elos.unindex
    end
  end
end
