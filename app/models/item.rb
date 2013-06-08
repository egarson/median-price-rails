#
# An Item is the object (formally speaking) of a Sale. For pedagogical purposes we model brand and year,
# although these attributes are certainly not common to all conceivable Items to say the least.
#
class Item < ActiveRecord::Base
  has_one :sale
  attr_accessible :brand, :year
end
