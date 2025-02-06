class FriendsController < ApplicationController
    def index
      if params[:friend].present?
        @friends = User.where("email LIKE ? OR first_name LIKE ? OR last_name LIKE ?", 
                              "%#{params[:friend]}%", "%#{params[:friend]}%", "%#{params[:friend]}%").where.not(id: current_user.id)
      else
        @friends = current_user.friends
      end
    end
end