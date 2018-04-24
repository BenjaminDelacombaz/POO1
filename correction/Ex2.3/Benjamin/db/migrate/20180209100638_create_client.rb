class CreateClient < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :firstname, limit: 50
      t.string :lastname, limit: 50
    end
  end
end
