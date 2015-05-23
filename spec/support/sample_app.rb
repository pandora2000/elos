Dir[File.expand_path('../../sample_app/**/*\.rb', __FILE__).to_s].each { |f| require(f) }

classes = [Entry, EEntryRepo, EEntry, AEntry]

classes.each do |klass|
  %i(find search).each do |method|
    klass.singleton_class.send(:alias_method, "_#{method}".to_sym, method)
    klass.define_singleton_method(method) do |*args|
      klass.refresh
      klass.send("_#{method}", *args)
    end
  end
end

RSpec.configure do |config|
  config.prepend_before do
    classes.each do |klass|
      klass.unindex
    end
  end
end
