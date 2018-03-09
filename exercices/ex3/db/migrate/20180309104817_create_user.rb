class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstname, limit: 50
      t.string :lastname, limit: 50
      t.string :email, limit: 255
    end
  end
end
