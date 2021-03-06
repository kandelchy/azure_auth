# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false, default: ""
      t.string :name
      t.integer :timeout, null: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
