class CreateSellings < ActiveRecord::Migration
  def change
    create_table :sellings do |t|
      t.text :paid
      t.text :change

      t.references :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :sellings, :products
  end
end
