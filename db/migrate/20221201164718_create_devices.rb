class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string   :name, null: false
      t.string   :device_type, null: false
      t.string   :device_no
      t.string   :os
      t.belongs_to   :user 
      t.timestamps
    end
  end
end
