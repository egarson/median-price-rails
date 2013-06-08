#
# A Sale in this context is an Item sold at a given price paid at a given time.
# TODO Once ascribed to an Item a Sale should not be able to be changed.
#
class Sale < ActiveRecord::Base
  belongs_to :item
  attr_accessible :item_id, :paid
end
