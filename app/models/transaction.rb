class Transaction < ActiveRecord::Base
  belongs_to :transactable, polymorphic:true


end
