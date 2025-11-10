# frozen_string_literal: true

class Session < ApplicationRecord
  acts_as_tenant :gym

  belongs_to :gym
  belongs_to :user

  before_create do
    self.user_agent = Current.user_agent
    self.ip_address = Current.ip_address
  end
end
