class CreateReservedItem < ActiveRecord::Migration[5.1]
  def change
    create_table :reserved_items do |t|
        t.references :reservation, foreign_key: true
        t.references :reservable, polymorphic: true
    end
  end
end
