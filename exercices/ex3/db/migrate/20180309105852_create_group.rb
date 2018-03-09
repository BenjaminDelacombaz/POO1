class CreateGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name, limit: 50
    end
  end
end
