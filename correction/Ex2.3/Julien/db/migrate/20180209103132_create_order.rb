class CreateOrder < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.datetime :created_at
      t.string :shipped_at
      t.string :datetime
      t.string :status, limit: 20
      t.references :client, foreign_key: true
    end
  end
end
