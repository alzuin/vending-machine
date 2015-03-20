# Class with the products
# * name: the item name
# * quantity: the item quantity in stock
# * value: the item price stored in pence
# * created_at: standard in RoR, is independent from the one that comes from the API
# * updated_at: standard in RoR, is independent from the one that comes from the API
# attr_accessor:
# * difference: the increasing/decreasing quantity
# has_many:
# * sellings: all the sales linked with this product

class Product < ActiveRecord::Base
  include MathOperations

  attr_accessor :difference

  validates_presence_of     :name, :quantity, :value
  validates_uniqueness_of   :name
  validates                 :quantity,   numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates                 :value,      numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates                 :difference, numericality: { only_integer: true }, :if => "difference.present?"


  before_save :update_quantity

  has_many :sellings

  def option_for_select
    "#{self.name} - #{self.value_in_pound} (#{self.quantity} in stock)"
  end
end
