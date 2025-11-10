# frozen_string_literal: true

class AddGymIdToUsers < ActiveRecord::Migration[8.1]
  def change
    add_reference :users, :gym, null: false, foreign_key: true
    # Email uniqueness should be per gym, drop global unique index if present and add scoped one
    remove_index :users, :email if index_exists?(:users, :email)
    add_index :users, [:gym_id, :email], unique: true
  end
end


