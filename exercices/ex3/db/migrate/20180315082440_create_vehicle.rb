class CreateVehicle < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :name, limit: 50
      t.string :manual, limit: 255
    end
  end
end
