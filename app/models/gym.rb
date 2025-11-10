# frozen_string_literal: true

class Gym < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :sessions, dependent: :destroy

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true,
                        format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }
end


