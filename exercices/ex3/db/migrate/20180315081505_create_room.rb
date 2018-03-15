class CreateRoom < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :name, limit: 50, unique: true
    end
  end
end
