class CreateLoads < ActiveRecord::Migration
  def change
    create_table :loads do |t|
      t.date :delivery_date
      t.integer :delivery_shift

      t.timestamps null: false
    end
  end
end
