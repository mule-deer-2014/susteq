class WaterServiceProvider < ActiveRecord::Base
  has_many :users
  has_many :hubs
end