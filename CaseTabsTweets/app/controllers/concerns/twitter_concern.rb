module TwitterConcern
	extend ActiveSupport::Concerns
	def twitter_client
		client ||= Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV["CONSUMER_KEY"]
		  config.consumer_secret     = ENV["CONSUMER_SECRET"]
		  config.access_token        = ENV["ACCESS_TOKEN"]
		  config.access_token_secret = ENV["ACCESS_SECRET"]  			
		end
		return client
	end
	def get_all_tweets page
		Rails.cache.fetch("#{page}_recent_tweets", expires_in: 5.seconds) do
			tweets_obj = twitter_client.user_timeline(page, count:20, exclude_replies: true, include_rts: false, result_type: "recent")
			tweets = []
			tweets_obj.each do |tweet|
				page_names = Set.new tweet.text.scan(/@[^\s]+/)
				text = tweet.text
				page_names.each do |page_name|
					user=twitter_client.user(page_name)
					text = tweet.text.gsub(page_name,"<a href=#{home_path(page_name)} title = (tweets:#{user.tweets_count},follows:#{user.followers_count}) 
						class=card-link>#{page_name}</a>")
				end
				tweets.push({date: tweet.created_at.to_date, text: text})
			end
			tweets
		end
		
	end
end
