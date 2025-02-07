class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @tracked_stocks = @user.stocks
    end
end