class Provider < ActiveRecord::Base
  has_many :employees, :dependent => :destroy
  has_many :pumps, :dependent => :destroy
  has_many :kiosks, :dependent => :destroy

  def hubs
    hubs = {kiosks: self.kiosks, pumps: self.pumps}
  end
end
