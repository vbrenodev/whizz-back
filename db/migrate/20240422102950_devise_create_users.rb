# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1] # rubocop:disable Style/Documentation
  def change
    create_table :users do |t|
      t.string :name,               null: false, default: ''
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
