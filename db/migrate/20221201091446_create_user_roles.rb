class CreateUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles do |t|
      t.string :role_type, null: false
      t.references :user

      t.timestamps
    end
  end
end