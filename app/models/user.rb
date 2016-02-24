class User < ActiveRecord::Base
  has_many :tools
  has_secure_password
end
