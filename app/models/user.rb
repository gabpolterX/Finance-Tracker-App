class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  def under_stock_limit?
    current_user.stocks.count < 10
  end
  
  def can_track_stock?(ticker_symbol)
    under_stock_limit?
  end

  def full_name
    return  "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def friends_with?(user)
    friends.include?(user)
  end

  def user_can_track?(ticker)
    !stocks.exists?(ticker: ticker) && stocks.count < 10
  end
end
