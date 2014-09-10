class Provider < ActiveRecord::Base
  has_many :employees, :dependent => :destroy
  has_many :pumps, :dependent => :nullify
  has_many :kiosks, :dependent => :nullify

  validates :name, presence: true, length: { maximum: 50 }
  validates :duns_number, presence: true, length: { maximum: 50 }
  def hubs
    hubs = {kiosks: self.kiosks, pumps: self.pumps}
  end
end
