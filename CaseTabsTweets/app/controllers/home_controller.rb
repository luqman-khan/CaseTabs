class HomeController < ApplicationController
	include TwitterConcern
	before_action :set_page_name, only: [:show]

	def index
		@tweets_obj = Rails.cache.fetch("Casetabs_recent_tweets", expires_in: 5.minutes) do
			twitter_client.user_timeline("@Casetabs", count:20, exclude_replies: true, include_rts: false, result_type: "recent")
		end
		# @tweets_obj=twitter_client.user_timeline("@LuqmanK55185700", count:20, exclude_replies: true, include_rts: false, result_type: "recent")
		@tweets= convert_to_tweets @tweets_obj
	end

	def show
		@tweets_obj = Rails.cache.fetch("#{@page_name}_recent_tweets", expires_in: 5.minutes) do
			twitter_client.user_timeline(@page_name, count:20, exclude_replies: true, include_rts: false, result_type: "recent")
		end
		@tweets= convert_to_tweets @tweets_obj
		render :index
	end

	private

	def set_page_name
		@page_name = params[:id]
	end
end
