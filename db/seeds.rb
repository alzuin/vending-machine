# Seed the coins

[1,2,5,10,20,50,100,200].each do |coin_size|
  Coin.create(value: coin_size , quantity: 0)
end