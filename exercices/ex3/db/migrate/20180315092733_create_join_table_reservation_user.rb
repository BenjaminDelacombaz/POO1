class CreateJoinTableReservationUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :reservations, :users do |t|
      # t.index [:reservation_id, :user_id]
      # t.index [:user_id, :reservation_id]
    end
  end
end
