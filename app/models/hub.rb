class Hub < ActiveRecord::Base
  belongs_to :provider
  has_many :transactions
end