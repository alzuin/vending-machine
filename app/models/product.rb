# Class with the products
# * name: the item name
# * quantity: the item quantity in stock
# * price: the item price stored in pence
# * created_at: standard in RoR, is independent from the one that comes from the API
# * updated_at: standard in RoR, is independent from the one that comes from the API

class Product < ActiveRecord::Base
  validates_presence_of :name, :quantity, :price
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price,    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
