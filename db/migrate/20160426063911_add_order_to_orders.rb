class AddOrderToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order, :integer
  end
end
