class HomeController < ApplicationController
	include TwitterConcern
	before_action :set_page_name

	def index
		## Use the line below if tweets does not contain user name
		# @page_name = "@LuqmanK55185700"

		@tweets= get_all_tweets @page_name
		respond_to do |format|
			format.html {}
			format.json {render json: @tweets, status: :success}
		end
	end

	def show
		@tweets = get_all_tweets @page_name
		respond_to do |format|
			format.html {render :index}
			format.json {render json: @tweets, status: :success}
		end
	end

	private

	def set_page_name
		@page_name = (params.has_key? :id) ? params[:id] : "@Casetabs"
	end
end
