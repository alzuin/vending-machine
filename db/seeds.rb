# Seed the coins

[1,2,5,10,20,50,100,200].each do |coin_size|
  Coin.create(size: coin_size , quantity: 0)
end