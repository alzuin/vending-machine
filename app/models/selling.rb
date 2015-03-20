# Class with the coin inside the vending machine
# * paid: an hash with the details of the payment
# * change: an hash with the details of the change
# * amount: the credit of the transaction in case there are no enough coins
# * created_at: standard in RoR, is independent from the one that comes from the API
# * updated_at: standard in RoR, is independent from the one that comes from the API
# belongs_to:
# * product: the product bought

class Selling < ActiveRecord::Base
  include MathOperations

  serialize :paid
  serialize :change

  belongs_to :product

  # initialize the two hash
  after_initialize do |selling|
    if selling.paid.nil?
      # if is nil, create an empty hash
      selling.paid  = create_hash
    else
      # if is not nil, convert an hash of strings coming from the parameters to an hash of integer
      # (ex.
      # {"1"=>"0", "2"=>"0", "5"=>"0", "10"=>"0", "20"=>"0", "50"=>"0", "100"=>"0", "200"=>"1"}
      # {1=>0, 2=>0, 5=>0, 10=>0, 20=>0, 50=>0, 100=>0, 200=>1}
      # )
      selling.paid = Hash[*selling.paid.to_a.flatten.map(&:to_i)]
    end
    # for change, always create an empty hash
    selling.change = create_hash if selling.change.nil?
  end

  validates_presence_of :paid
  validate :paid_enough?
  validate :enough_product?

  before_save :deposit_and_change
  after_save :give_product

  # calculates the total amount paid
  def total_paid
    total = 0
    self.paid.each do |coin, how_many|
      total += coin * how_many
    end
    total
  end


  private

  # check if there are enough product to sell
  def enough_product?
    errors.add(:product, 'There are no enough products') unless self.product.quantity > 0
  end

  # check if the customer paid enough
  def paid_enough?
    errors.add(:paid,'You don\'t paid enough') unless self.product.value <= self.total_paid
  end

  # decrease by 1 the number of products
  def give_product
    self.product.update(difference: -1)
  end

  # deposit the inserted money inside the Vending Machine,
  # and create the change
  def deposit_and_change
    # deposit the money
    self.paid.each do |coin, how_many|
      Coin.find_by_value(coin).update(difference: how_many)
    end

    # calculate the absolute value of the change
    self.amount = self.total_paid - self.product.value

    while self.amount > 0
      # calculate the best option for the change with the coins with quantity > 0, but without checking if they are enough
      # (imagine an infinite value)
      to_return = create_change(amount)
      # exit if there are no more coin useful for the change inside the vending machine
      break if self.amount > 0 and to_return.empty?

      # coming from the bigger coin size, return the coins to the user
      self.amount = 0
      to_return.each do |coin, how_many|
        coin_in_deposit = Coin.find_by_value(coin)
        if coin_in_deposit.quantity >= how_many
          # if the coin quantity is enough simply return all needed coins
          self.change[coin].nil? ? self.change[coin] = how_many : self.change[coin] += how_many
          coin_in_deposit.update(difference: how_many * -1)
        else
          # if the coin quantity is not enough, return the maximum available and keep the credit
          self.amount += coin * (how_many-coin_in_deposit.quantity)
          self.change[coin].nil? ? self.change[coin] = coin_in_deposit.quantity : self.change[coin] += coin_in_deposit.quantity
          coin_in_deposit.update(difference: coin_in_deposit.quantity * -1)
        end
      end
    end
  end

  # initialize the hash with the coins with quantity = 0
  def create_hash
    temp = Hash.new
    Coin.all.each do |coin|
      temp[coin.value] = 0
    end
    temp
  end

  # create a change with the available coin (>0), but without checking the maximum number
  def create_change(amount)
    coins = Coin.all.map{ |coin| coin.value unless coin.quantity.nil? or coin.quantity == 0 }.compact

    # an acceptable solution could be something like
    # coins.sort.
    #   reverse.
    #   map{|coin| f = amount/coin; amount %= coin; Array.new(f){coin} }.
    #   flatten
    # Instead I used an hash to temporary store the result to improve (a lot) the speed

    coins.sort! { |a, b| b <=> a }

    # memoize solutions
    optimal_change = Hash.new do |hash, key|
      hash[key] = if key < coins.min
                    []
                  elsif coins.include?(key)
                    [key]
                  else
                    coins.
                        # prune unhelpful coins
                        reject { |coin| coin > key }.

                        # prune coins that are factors of larger coins
                        inject([]) {|mem, var| mem.any? {|c| c%var == 0} ? mem : mem+[var]}.

                        # recurse
                        map { |coin| [coin] + hash[key - coin] }.

                        # prune unhelpful solutions
                        reject { |change| change.sum != key }.

                        # pick the smallest, empty if none
                        min { |a, b| a.size <=> b.size } || []
                  end
    end

    # here we have an array with multiple values
    values = optimal_change[amount]
    # let's create an hash simplified
    hash_to_return = {}
    values.uniq.each do |key|
      hash_to_return[key] = values.count(key)
    end

    hash_to_return
  end
end
