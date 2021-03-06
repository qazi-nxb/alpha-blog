class UsersController < ApplicationController
  before_action :user_finder, only: [:edit, :show, :update]
  before_action :require_user, only: [:show]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only:[:destroy]
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success]="User Added successfully"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success]= "User Updated Succcessfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  def show
    @user_articles= @user.articles.paginate(page: params[:page], per_page: 1)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "All user and their articles are deleted"
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :useremail, :password)
  end
  def user_finder
    @user = User.find(params[:id])
  end
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You don't have rights to do this"
      redirect_to root_path
    end
  end
  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin can delete this"
      redirect_to root_path
    end
  end

end
