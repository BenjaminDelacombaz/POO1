class CreateProduct < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, limit: 50, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.string :description
      t.references :category, foreign_key: true
    end
  end
end
