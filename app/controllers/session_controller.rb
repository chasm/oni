class SessionController < ApplicationController
  before_action :is_not_authenticated?, except: [ :destroy ]

  def new
  end

  def create
    if user = User.find_by_email(params[:user][:email])
      if user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        redirect_to root_url
      else
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end

  private

  def is_not_authenticated?
    redirect_to root_url unless session[:user_id].nil?
  end
end
