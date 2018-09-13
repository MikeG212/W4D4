class UsersController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      log_in!
      # redirect_to
    else
      flash.now[:errors] =@users.errors.full_messages
      render :new
    end
  end
  



  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
