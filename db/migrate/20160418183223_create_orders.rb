class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :delivery_date
      t.integer :delivery_shift
      t.string :origin_name
      t.string :origin_raw_line_1
      t.string :origin_city
      t.string :origin_state
      t.string :origin_zip
      t.string :origin_country
      t.string :client_name
      t.string :destination_raw_line_1
      t.string :destination_city
      t.string :destination_state
      t.string :destination_zip
      t.string :destination_country
      t.string :phone_number
      t.integer :mode
      t.string :purchase_order_number
      t.decimal :volume
      t.integer :handling_unit_quantity
      t.integer :handling_unit_type

      t.timestamps null: false
    end
  end
end
