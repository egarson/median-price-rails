class Item < ActiveRecord::Base
  has_one :sale
  attr_accessible :brand, :year
end
