# Class with the coin inside the vending machine
# * size: the coin size in pence (1p 5p); for 1 Pound, insert 100p; for 2 Pound, insert 200p
# * quantity: the item quantity in stock
# * created_at: standard in RoR, is independent from the one that comes from the API
# * updated_at: standard in RoR, is independent from the one that comes from the API

class Coin < ActiveRecord::Base
  validates_presence_of :size, :quantity
  validates :size, numericality: { only_integer: true }, inclusion: { in: [1,2,5,10,20,50,100,200] }
  validates_uniqueness_of :size
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
