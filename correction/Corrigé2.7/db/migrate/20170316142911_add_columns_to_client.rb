class AddColumnsToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :type, :string, limit: 50
    add_column :clients, :name, :string, limit: 50
    
    change_column_null :clients, :firstname, true
    change_column_null :clients, :lastname, true
  end
end
