class Provider < ActiveRecord::Base
  has_many :users
  has_many :hubs

  def hubs 
    hubs = {kiosks: self.kiosks, pumps: self.pumps}
  end
end
