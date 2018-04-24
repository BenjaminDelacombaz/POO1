class CreateProduct < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, limit: 50
      t.decimal :price, precision: 8, scale: 2
      t.string :description
      t.references :category, foreign_key: true
    end
  end
end
