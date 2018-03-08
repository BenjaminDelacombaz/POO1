class CreateSupplier < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
      t.string :name, limit: 50
    end
  end
end
