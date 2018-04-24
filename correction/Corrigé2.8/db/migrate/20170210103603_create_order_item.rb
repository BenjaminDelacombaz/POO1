class CreateOrderItem < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity, null: false
      t.decimal :item_price, precision: 8, scale: 2, null: false
      t.references :order, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false
    end
  end
end
