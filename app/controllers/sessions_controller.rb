class SessionsController < ApplicationController
  before_action :require_log_in, only: [:new, :create]
  before action :require_log_out, only: [:destroy]

  def new
      @session = Session.new
      render :new
  end

  def create #LogIn
    @user = User.find_by_credentials(
      [:user][:email],
      [:user][:password]
    )

    if !!@user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:error] = ['Nope... not today!']
      render :new
  end

  def destroy #LogOut
    logout!
    redirect_to new_session_url
  end







end
