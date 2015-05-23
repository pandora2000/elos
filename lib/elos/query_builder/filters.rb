module Elos::QueryBuilder::Filters
  extend ActiveSupport::Concern

  def or_filter(*filters)
    filters = filters.first if filters.first.is_a?(Array)
    filters.compact!
    { or: filters } unless filters.empty?
  end

  def and_filter(*filters)
    filters = filters.first if filters.first.is_a?(Array)
    filters.compact!
    { and: filters } unless filters.empty?
  end

  def term_filter(key, params_sym = nil, value: nil)
    v = value.nil? ? params[params_sym || key] : value
    { term: { key => v } } unless v.nil?
  end

  def terms_filter(key, params_sym = nil, values: nil)
    v = value.nil? ? params[params_sym || key.to_s.pluralize.to_sym] : value
    { terms: { key => v } } unless v.empty?
  end

  def exists_filter(key)
    { exists: { field: key } }
  end

  def missing_filter(key)
    { missing: { field: key } }
  end

  def range_filter(key, min: nil, max: nil)
    return unless min || max
    r = { range: { key => {} } }
    r[:range][key][:gte] = min if min
    r[:range][key][:lte] = max if max
    r
  end
end
