class Elos::Lock
  include Elos::Index::Core
  include Elos::Index::Properties
  include Elos::Index::Mappings

  mappings -> do
    {
      _all: { enabled: false },
      _ttl: { enabled: true, default: '5d' },
      properties: { lock: boolean_property }
    }
  end

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
end
