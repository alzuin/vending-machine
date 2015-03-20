module SellingsHelper
  # Convert an hash with the details of the payment in something decent for a web page
  def print_paid_hash(hash)
    print_hash(hash,hash.paid)
  end

  # Convert an hash with the details of the change in something decent for a web page
  def print_change_hash(hash)
    print_hash(hash,hash.change)
  end

  # Create a group of <p> with the useful values
  def print_hash(hash,value)
    output = ''
    value.each do |coin,quantity|
      output += "<p>n.#{quantity} - #{hash.number_to_pound(coin)}</p>"
    end
    raw(output)
  end
end
