class Category
	include NoBrainer::Document
	include NoBrainer::Document::Timestamps

	has_many :threads, class_name: 'ForumThread'

	field :name, type: String
	field :thread_count, type: Integer, default: 0
	field :post_count, type: Integer, default: 0

	def last_thread
		@last_thread ||= self.threads.order_by('updated_at DESC').first
	end

	def update_counters
		self.thread_count = self.threads.count
		self.post_count = self.threads.map(&:post_count).sum
		save
	end
end
