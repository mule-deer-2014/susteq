class Provider < ActiveRecord::Base
  has_many :users
  has_many :hubs
end