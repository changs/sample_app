class UsersController < ApplicationController
  before_filter :signed_in_filter, only: [:create, :new]
  before_filter :authenticate, except: [:show, :new, :create]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  def new
    @user = User.new
    @title = "Sign up"
  end

  def index
    @title = "All users"
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user      
    else
      @title = 'Sign up'
      @user.password = ''
      @user.password_confirmation = ''
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy unless User.find(params[:id]).admin?
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    def signed_in_filter
      redirect_to(root_path) if signed_in?
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_path) unless current_user.admin
    end
end
