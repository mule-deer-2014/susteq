class Transaction < ActiveRecord::Base
  belongs_to :transactable, polymorphic:true
  scope :credits_sold, -> { where(transaction_code: [20,21]) }


end
