class Sale < ActiveRecord::Base
  belongs_to :item
  attr_accessible :category, :paid, :item_id
end
