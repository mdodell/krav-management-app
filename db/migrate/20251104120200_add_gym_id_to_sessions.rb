# frozen_string_literal: true

class AddGymIdToSessions < ActiveRecord::Migration[8.1]
  def change
    add_reference :sessions, :gym, null: false, foreign_key: true
    add_index :sessions, [:gym_id, :user_id]
  end
end