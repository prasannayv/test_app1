class SessionsController < ApplicationController
   skip_before_filter :authorize
  def new
  end

  def create
    logger.info "***************************************************"
    logger.info params[:hashed_password]
    logger.info "***************************************************"
    if user = User.authenticate(params[:name], params[:hashed_password])
      session[:user_id] = user.id
      redirect_to admin_index_path
    else
      redirect_to new_session_path, :alert => "Invalid user/password combination"
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_path, :notice => "Logged out"

  end

end
