class ForumThread
	include NoBrainer::Document
	include NoBrainer::Document::Timestamps

	belongs_to :category
	belongs_to :user
	has_many :posts, foreign_key: :thread_id

	validates :category, :user, presence: true

	field :title, type: String, required: true
	field :post_count, type: Integer, default: 0

	after_save :update_category_counters

	def update_counters
		self.post_count = self.posts.count
		save
	end

	private
	def update_category_counters
		self.category.update_counters
	end

end
