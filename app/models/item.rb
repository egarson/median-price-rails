#
# An Item is an object that can be sold and that has some price-related attributes. For pedagogical purposes,
# those attributes are brand and year, and they are static (i.e. defined at compile time).
#
# TODO: Dynamically ascribe attributes based on Category, and wire them up dynamically.
#
class Item < ActiveRecord::Base
  attr_accessible :brand, :year, :paid

  def sold?
	paid != nil  # presence of paid field implies sold
  end

  # the collection of sold Items
  def self.sold(brand = '%')
	Item.where(PAID_NOT_NULL + AND_BRAND_LIKE, brand)
  end

  def self.median(brand = '%', years = nil)
	raise 'Years must either be nil or [year_from, year_to]' if years and years.length != 2
	stmt = PAID_NOT_NULL + AND_BRAND_LIKE
	stmt += AND_YEAR_IS if years
	years != nil ?
	  Item.where(stmt, brand, years[0], years[1]).average(:paid) :
	  Item.where(stmt, brand).average(:paid)
  end
end
