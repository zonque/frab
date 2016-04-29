module NumberHelper
  def to_currency(i)
    options = {}
    options[:unit]   = ENV['FRAB_CURRENCY_UNIT'].dup.force_encoding("UTF-8")   unless ENV['FRAB_CURRENCY_UNIT'].nil?
    options[:format] = ENV['FRAB_CURRENCY_FORMAT'].dup.force_encoding("UTF-8") unless ENV['FRAB_CURRENCY_FORMAT'].nil?

    number_to_currency i, options
  end
end
