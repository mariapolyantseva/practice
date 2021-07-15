class CommentsController < ApplicationController
  before_action :load_user, :load_post
  
  def new
    @comment = Comment.new
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
      if @comment.save 
        redirect_to user_post_path(@user, @post)
      end
  end

  def update
      @comment = @post.comments.find(params[:id])
      @comment.update(comment_params)
      
      redirect_to user_post_comment_path(@user, @post, @comment)
    
  end

  def destroy
    @comment = @post.comments.where(post_id: @post).take 
    @comment.destroy
    
    redirect_to user_post_path(@user, @post)     
  end

  private

    def load_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:user_name, :comment, :post_id)
    end

    def load_user
      @user = User.find(params[:user_id])
    end

end
