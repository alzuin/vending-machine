module MathOperations
  extend ActiveSupport::Concern

  def update_quantity
    self.quantity += self.difference.to_i unless self.difference.nil?
    false if self.quantity < 0
  end

  def value_in_pound
    if self.value < 100
      "#{self.value}p"
    elsif self.value >= 100
      "#{(self.value.to_f/100).round(2)}P"
    else
      'ERR'
    end
  end
end