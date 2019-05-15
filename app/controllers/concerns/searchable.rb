require 'active_support/concern'

module Searchable
  extend ActiveSupport::Concern

  private

  def perform_search(models, params, options)
    if params.key?(:term) and params[:term].present?
      term = params[:term]
      terms = options.map { |o| [o, term] }.to_h
      terms[:m] = 'or'
      terms[:s] = params.dig(:q, :s)
      r = models.ransack(terms)
    else
      r = models.ransack(params[:q])
    end

    r.sorts = 'created_at desc' if r.sorts.empty?
    r
  end
end
