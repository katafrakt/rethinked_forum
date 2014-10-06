class PostsController < ApplicationController
	def create
		@thread = ForumThread.find(params[:forum_thread_id])
		@post = Post.new(safe_params)
		@post.thread = @thread
		@post.user = current_user
		if @post.save
			redirect_to forum_thread_path(@thread)
		else
			render :new
		end
	end

	private
	def safe_params
		params.require(:post).permit(:content)
	end
end
