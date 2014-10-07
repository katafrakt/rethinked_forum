class ThreadTagsController < ApplicationController
	def show
		@threads = ForumThread.where(tags: params[:tag]).with_index(:tags)
	end
end
