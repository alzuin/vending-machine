class RenameSizeAndPriceInValue < ActiveRecord::Migration
  def change
    rename_column :coins, :size, :value
    rename_column :products, :price, :value
  end
end
