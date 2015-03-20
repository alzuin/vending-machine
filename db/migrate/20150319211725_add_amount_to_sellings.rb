class AddAmountToSellings < ActiveRecord::Migration
  def change
    add_column :sellings, :amount, :integer, default: 0
  end
end
