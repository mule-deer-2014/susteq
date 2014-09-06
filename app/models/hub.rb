class Hub < ActiveRecord::Base
  has_many :transactions
end