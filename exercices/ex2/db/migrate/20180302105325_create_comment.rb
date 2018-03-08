class CreateComment < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content, limit: 255
      t.references :client, foreign_key: true
      t.references :commentable, polymorphic: true
    end
  end
end
