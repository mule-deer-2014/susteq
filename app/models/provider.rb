class Provider < ActiveRecord::Base
  has_many :employees
  has_many :pumps
  has_many :kiosks

  def hubs 
    hubs = {kiosks: self.kiosks, pumps: self.pumps}
  end
end
