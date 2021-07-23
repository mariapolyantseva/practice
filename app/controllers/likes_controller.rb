class LikesController < ActionController::Base
	before_action :authenticate_user!
	before_action :load_user, :load_post

	def create
		if !current_user.likes.exists?(post_id: @post)

			@like = current_user.likes.build(post: @post)

			if @like.save!
        		redirect_to user_post_path(@user, @post)
      		end
		end
	end

	def destroy
		if current_user.likes.exists?(post_id: @post)

			@like = current_user.likes.where(post_id: @post).take
			@like.destroy

			redirect_to user_post_path(@user, @post)
		end
	end

	private

	def load_user
		@user = User.find(params[:user_id])
	end
	def load_post
		@post = Post.find(params[:post_id])
	end
end