class ForumThreadsController < ApplicationController
	include PostParams

	def show
		@thread = ForumThread.find(params[:id])
		@posts = @thread.posts.order_by(:created_at).preload(:user)
	end

	def new
		@category = Category.find(params[:category_id])
		@thread = ForumThread.new
		#@thread.posts << Post.new(thread: @thread)
	end

	def create
		@category = Category.find(params[:category_id])
		post_params = safe_post_params(params[:forum_thread].delete(:posts))
		@thread = ForumThread.new(safe_params)
		@thread.category = @category
		post = Post.new(post_params)
		post.thread = @thread
		post.user = @thread.user = current_user
		if @thread.save? && post.save?
			@thread.save
			post.save
			redirect_to @thread
		else
			flash[:post_content] = post.content
			render :new
		end
	end

	private
	def safe_params
		params.require(:forum_thread).permit(:title)
	end
end
