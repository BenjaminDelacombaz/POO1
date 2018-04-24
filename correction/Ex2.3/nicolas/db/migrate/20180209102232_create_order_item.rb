class CreateOrderItem < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.decimal :item_price, precision: 8, scale: 2
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
