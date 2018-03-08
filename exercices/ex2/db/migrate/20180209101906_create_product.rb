class CreateProduct < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, limit: 50
      t.decimal :price, precision: 10, scale: 2
      t.string :description, limit: 254
    end
  end
end
