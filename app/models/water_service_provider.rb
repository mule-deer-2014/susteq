class WaterServiceProvider < ActiveRecord::Base
  has_many :employees
  has_many :hubs
end