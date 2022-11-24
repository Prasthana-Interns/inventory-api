class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :emp_id
      t.string :name
      t.bigint :phone_number
      t.string :email,uniqueness: true, null: false
      t.string :designaton
      t.string :password_digest
      t.boolean :approved,default: false

      t.timestamps
    end
  end
end
