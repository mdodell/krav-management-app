# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_current_tenant
  before_action :set_current_request_details
  before_action :authenticate

  private

  def authenticate
    if ActsAsTenant.current_tenant.nil?
      redirect_to root_path, alert: "Please use your gym subdomain to sign in"
      return
    end

    redirect_to sign_in_path unless perform_authentication
  end

  def require_no_authentication
    return unless perform_authentication

    flash[:notice] = "You are already signed in"
    redirect_to root_path
  end

  def perform_authentication
    Current.session ||= Session.find_by_id(cookies.signed[:session_token])
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end

  def set_current_tenant
    sub = request.subdomains.first
    return ActsAsTenant.current_tenant = nil if sub.blank?

    gym = Gym.find_by(subdomain: sub)
    ActsAsTenant.current_tenant = gym
  end

  def ensure_tenant!
    return if ActsAsTenant.current_tenant.present?
    redirect_to root_path, alert: "Please access via your gym subdomain"
  end
end
