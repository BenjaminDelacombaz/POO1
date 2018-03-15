class CreateJoinTableEquipmentUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :equipment, :users do |t|
      # t.index [:equipment_id, :user_id]
      # t.index [:user_id, :equipment_id]
    end
  end
end
