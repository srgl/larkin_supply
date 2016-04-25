class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  enum role: [:dispatcher, :driver]
end
