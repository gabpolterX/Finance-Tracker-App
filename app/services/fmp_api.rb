class FmpApi
  include HTTParty
  base_uri 'https://financialmodelingprep.com/api/v3'

  def initialize
    @api_key = Rails.application.credentials.fmp[:api_key]
  end

  def stock_quote(symbol)
    response = self.class.get("/quote/#{symbol}", query: { apikey: @api_key })

    if response.success? && response.parsed_response.present?
      return response.parsed_response
    else
      return nil
    end
  end
end