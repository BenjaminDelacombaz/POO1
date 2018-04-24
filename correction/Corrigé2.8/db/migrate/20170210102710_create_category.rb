class CreateCategory < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name, limit: 50, null: false
      t.string :description
    end
  end
end
