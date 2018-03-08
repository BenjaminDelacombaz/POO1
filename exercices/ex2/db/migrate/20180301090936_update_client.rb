class UpdateClient < ActiveRecord::Migration[5.1]
  def change
    change_table :clients do |t|
      t.string :type, limit: 50
    end
  end
end
