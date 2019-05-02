module TwitterConcern
	extend ActiveSupport::Concerns
	def twitter_client
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV["CONSUMER_KEY"]
		  config.consumer_secret     = ENV["CONSUMER_SECRET"]
		  config.access_token        = ENV["ACCESS_TOKEN"]
		  config.access_token_secret = ENV["ACCESS_SECRET"]  			
		end
		return client
	end
	def convert_to_tweets tweets_obj
		tweets = []
		tweets_obj.each do |tweet|
			page_names = Set.new tweet.text.scan(/@[^\s]+/)
			text = tweet.text
			page_names.each do |page_name|
				text = tweet.text.gsub(page_name,"<a href=#{home_path(page_name)} class=card-link>#{page_name}</a>")
			end
			tweets.push({date: tweet.created_at.to_date, text: text})
		end
		return tweets
	end
end
