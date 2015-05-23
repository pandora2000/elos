module Elos::Repository::Adapter::Elos::Scanable
  extend ActiveSupport::Concern

  class_methods do
    def scan(batch_size = nil, &block)
      _scan(batch_size) do |hit|
        block.(new(hit['_source'].merge(id: hit['_id'], _persisted: true)))
      end
    end

    protected

    def _scan(batch_size = nil, index_name: read_alias_name, &block)
      batch_size ||= 100
      scroll_id = client.search(index: index_name, type: type_name, search_type: :scan, scroll: '1h', body: { query: { match_all: {} }, size: batch_size })['_scroll_id']
      while r = client.scroll(scroll: '1h', scroll_id: scroll_id) and (hits = r['hits']['hits']).present? do
        scroll_id = r['_scroll_id']
        hits.each do |hit|
          block.(hit)
        end
      end
    end
  end
end
