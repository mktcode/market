class AddTimeInvestedToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :time_invested, :decimal
  end
end
