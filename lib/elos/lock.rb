class Elos::Lock
  include Elos::Index::Core

  def self.lock(key, &block)
    create_index(index_name)
    id = SecureRandom.uuid
    body = { doc: {}, upsert: { lock: id } }
    client.update(index: index_name, type: type_name, id: key, body: body)
    if client.get(index: index_name, type: type_name, id: key)['_source']['lock'] == id
      if block
        begin
          ret = block.()
        ensure
          unlock(key)
        end
      else
        true
      end
    end
  end

  def self.unlock(key)
    client.delete(index: index_name, type: type_name, id: key)
  rescue Elasticsearch::Transport::Transport::Errors::NotFound
  end

  private

  def self.mappings
    {
      type_name => {
        _all: { enabled: false },
        _ttl: { enabled: true, default: '5d' },
        properties: properties
      }
    }
  end

  def self.properties
    {
      boolean_property => %i(lock)
    }.inject({}) { |m, x| m.merge(Hash[x[1].map { |y| [y, x[0]] }]) }
  end

  def self.boolean_property
    { type: 'boolean' }
  end
end
