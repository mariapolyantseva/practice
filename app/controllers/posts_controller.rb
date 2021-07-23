class PostsController < ApplicationController
  before_action :load_user 

  def index
    @posts = @user.posts
  end
  
  def show 
    @post = @user.posts.find(params[:id]) 
  end

  def new
    @post = Post.new
  end

  def edit
    @post = @user.posts.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = @user
      if @post.save
          redirect_to user_post_path(@user, @post), flash: {success: "Post was added"}
      else
          render action: :new
      end
  end 


  def update
    @post = @user.posts.find(params[:id])
    @post.update(post_params)
    
    redirect_to user_post_path(@user, @post)
  end 

  def destroy
    @post = @user.posts.find(params[:id])
    @post.destroy
    render action: :index
  end


  private

    def post_params
      params.require(:post).permit(:user_name, :user_id, :description, :image)
    end

    def load_user
      @user = User.find(params[:user_id])
    end
end
