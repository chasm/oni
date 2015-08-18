class SiteController < ApplicationController
  # Redirect to login page unless logged in for home page only
  before_action :is_authenticated?, only: [ :index ]

  # Home page (root)
  def index
  end

  # Unprotected terms of use page
  def terms
  end

  private

  def is_authenticated?
    # Redirect to login page unless logged in
    redirect_to login_url if session[:user_id].nil?
  end
end
