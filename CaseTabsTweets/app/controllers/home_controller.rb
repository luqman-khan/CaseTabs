class HomeController < ApplicationController
	include TwitterConcern
	def index
		# @tweets = [{title: "Luqman", text: "Computer Scientist"},{title: "Sulaiman", text: "Computer Engineer"},{title: "Sulaiman", text: "Computer Engineer"},{title: "Sulaiman", text: "Computer Engineer"}]
		
		@tweets = Rails.cache.fetch("recent_tweets", expires_in: 5.minutes) do
			twitter_client.user_timeline("Casetabs", count:20, exclude_replies: true, include_rts: false, result_type: "recent")
		end
		aaa
	end
end
