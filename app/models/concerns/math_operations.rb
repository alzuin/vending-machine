# This module has some function common to the other modules
module MathOperations
  extend ActiveSupport::Concern

  # Update the quantity of something (product or coin) inside the Vending Machine
  # Returns false in case of a negative return value
  def update_quantity
    self.quantity += self.difference.to_i unless self.difference.nil?
    false if self.quantity < 0
  end

  # Convert the value field to pound
  def value_in_pound
    number_to_pound(self.value)
  end

  # Convert a number in pence to pound
  def number_to_pound(number)
    if number < 100
      "#{number}p"
    elsif number >= 100
      "#{(number.to_f/100).round(2)}P"
    else
      'ERR'
    end
  end
end