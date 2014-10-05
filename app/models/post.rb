class Post
	include NoBrainer::Document
	include NoBrainer::Document::Timestamps

	belongs_to :user, required: true
	belongs_to :thread, class_name: 'ForumThread'

	field :content, type: String, required: true

	after_save :update_thread_counters

	private
	def update_thread_counters
		self.thread.update_counters
	end
end
