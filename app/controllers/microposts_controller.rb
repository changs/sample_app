class MicropostsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, only: [ :destroy ]

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items= []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Deleted"
    redirect_back_or root_path
  end

  def index
    user = User.find(params[:user_id])
    @feed_items = user.microposts.paginate(page: params[:page])
  end
  private

  def authorized_user
    @micropost = Micropost.find(params[:id])
    redirect_to root_path unless current_user?(@micropost.user)
  end
end
