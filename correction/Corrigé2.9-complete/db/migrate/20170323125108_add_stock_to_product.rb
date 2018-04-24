class AddStockToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :stock_count, :integer
  end
end
