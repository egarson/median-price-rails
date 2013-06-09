#
# An Item is an object that can be sold and that has some price-related attributes. For pedagogical purposes,
# those attributes are brand and year, and they are static (i.e. defined at compile time).
#
# TODO: Dynamically ascribe attributes based on Category, and wire them up dynamically.
#
class Item < ActiveRecord::Base
  attr_accessible :brand, :year, :paid

  def sold
	puts self.inspect
	paid != nil  # presence of paid field implies sold
  end
end
