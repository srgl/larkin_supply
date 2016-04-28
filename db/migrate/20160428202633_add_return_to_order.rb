class AddReturnToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :return, :boolean
  end
end
