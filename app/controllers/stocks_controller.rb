class StocksController < ApplicationController
  def index
    if params[:stock].present?
      symbol = params[:stock].upcase
      fmp = FmpApi.new
      @quote = fmp.stock_quote(symbol)

      if @quote.nil? || @quote.empty?
        flash[:alert] = "No data available for this symbol."
        @quote = nil
      end
    else
      flash[:alert] = "Please enter a stock symbol"
      render :index
    end
  end
end