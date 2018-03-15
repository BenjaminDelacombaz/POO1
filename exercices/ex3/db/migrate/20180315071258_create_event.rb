class CreateEvent < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name, limit: 50
      t.datetime :start
      t.datetime :end
      t.references :creator_user, foreign_key: { to_table: :users }
      t.references :created_for_user, foreign_key: { to_table: :users }
    end
  end
end
