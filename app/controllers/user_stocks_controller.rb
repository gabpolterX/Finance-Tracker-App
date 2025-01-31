class UserStocksController < ApplicationController
    before_action :authenticate_user!
  
    def create
      stock = Stock.find_by(ticker: params[:ticker])
  
      unless stock
        stock_data = FmpApi.new.stock_quote(params[:ticker])
        if stock_data.present? && stock_data.is_a?(Array) && stock_data.first.is_a?(Hash)
          stock_info = stock_data.first
          stock = Stock.create(
            ticker: stock_info["symbol"],
            name: stock_info["name"],
            last_price: stock_info["price"]
          )
        else
          flash[:alert] = "Stock not found."
          redirect_to stocks_path and return
        end
      end
  
      if UserStock.find_by(user: current_user, stock: stock)
        flash[:alert] = "You already have this stock in your portfolio."
      else
        current_user.user_stocks.create(stock: stock)
        flash[:notice] = "#{stock.name} was successfully added to your portfolio."
      end
  
      redirect_to stocks_path
    end
  end