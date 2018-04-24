class CreateClient < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :firstname, limit: 50, null: false
      t.string :lastname, limit: 50, null: false
    end
  end
end
