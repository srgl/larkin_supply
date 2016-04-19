class AddLoadToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :load, index: true, foreign_key: true
  end
end
