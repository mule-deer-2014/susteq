class Provider < ActiveRecord::Base
  has_many :employees
  has_many :pumps
  has_many :kiosks

end
