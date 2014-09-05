class WaterServiceProvider < ActiveRecord::Base
  has_many :employees
  has_many :pumps
  has_many :purchases
end