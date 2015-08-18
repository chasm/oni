class SiteController < ApplicationController
  before_action :is_authenticated?, only: [ :index ]

  def index
  end

  def terms
  end

  private

  def is_authenticated?
    redirect_to login_url if session[:user_id].nil?
  end
end
