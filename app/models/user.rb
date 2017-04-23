class User < ActiveRecord::Base
  has_many :adults
  has_many :children

  validates_presence_of :username, :email, :password

  has_secure_password
end
