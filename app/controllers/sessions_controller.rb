class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to messages_url
    else
      flash.now[:danger] = 'Username or Password combination is invalid.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end
end
