class Elos::Criteria < Elos::Result
  def initialize(params:, query_builder_class:, klass:)
    @client = Elos.client
    @params = params
    @query_builder_class = query_builder_class
    @klass = klass
  end

  def page(page)
    @params[:page] = page
    self
  end

  def per(per = nil)
    if per
      @params[:per] = per
      self
    else
      @params[:per]
    end
  end

  alias_method :limit, :per

  def includes(*names)
    @includes = names
    self
  end

  def total_count
    result
    @total_count
  end

  def current_page
    @params[:page]
  end

  def total_pages
    [0, total_count - 1].max / @params[:per] + 1
  end

  def first_page?
    current_page == 1
  end

  def last_page?
    current_page == total_pages
  end

  def to_a!
    r = to_a
    raise Elos::Errors::NotFound if r.empty?
    r
  end

  def first!
    r = first
    raise Elos::Errors::NotFound unless r
    r
  end

  def query
    @query_builder_class.new(@params.merge(class: @klass)).wrap_build
  end

  protected

  def result
    return @result if @result
    search_result = @client.search(index: @klass.read_alias_name, type: @klass.type_name, body: query)
    # puts JSON.pretty_generate(results)
    @total_count = search_result['hits']['total']
    @results = search_result['hits']['hits'].map do |h|
      source = h['_source']
      if json = source.delete('json')
        source.reverse_merge!(JSON.parse(json))
      end
      source.deep_symbolize_keys!
      @klass.new(source.reverse_merge(score: h['_score'], highlight: h['highlight']).merge(id: h['_id'], _persisted: true))
    end
  end
end
