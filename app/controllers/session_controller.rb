class SessionController < ApplicationController
  # redirect to the root page unless NOT logged in
  before_action :is_not_authenticated?, except: [ :destroy ]

  # Display the login form
  def new
  end

  # Log the user in
  def create
    # Find the user
    if user = User.find_by_email(params[:user][:email])
      # Test the user's password
      if user.authenticate(params[:user][:password])
        # Log the user in and redirect to root page
        session[:user_id] = user.id
        redirect_to root_url
      else
        # Bad password -- rerender the form
        render :new
      end
    else
      # Can't find user -- rerender the form
      render :new
    end
  end

  # Log the user out and redirect to the login form
  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end

  private

  def is_not_authenticated?
    # Redirect to the root page unless the user is NOT logged in
    redirect_to root_url unless session[:user_id].nil?
  end
end
