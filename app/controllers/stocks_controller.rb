class StocksController < ApplicationController
  def show
    symbol = params[:id] 
    fmp = FmpApi.new
    @quote = fmp.stock_quote(symbol)

    if @quote.nil? || @quote.empty?
      flash[:alert] = "No data available for this symbol."
      @quote = [] 
    end
  end
end