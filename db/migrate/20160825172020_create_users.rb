class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.index :email, unique: true
      t.string :hashed_password

      t.timestamps null: false
    end
  end
end