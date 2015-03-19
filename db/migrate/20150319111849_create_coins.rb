class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.integer :size
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
