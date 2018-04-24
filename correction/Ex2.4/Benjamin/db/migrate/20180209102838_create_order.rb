class CreateOrder < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.datetime :created_at
      t.datetime :shipped_at
      t.integer :status, limit:1
      t.references :client, foreign_key: true
    end
  end
end
