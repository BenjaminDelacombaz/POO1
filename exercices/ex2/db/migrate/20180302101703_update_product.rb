class UpdateProduct < ActiveRecord::Migration[5.1]
  def change
    change_table :products do |t|
      t.references :supplier, foreign_key: true
    end
  end
end
