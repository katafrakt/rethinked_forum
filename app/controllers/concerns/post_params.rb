module PostParams
	def safe_post_params(hash=params)
		hash.permit(:content)
	end
end