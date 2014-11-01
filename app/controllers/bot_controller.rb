class BotController < ApplicationController

	def index
	end

	def callback
		@client = GroupMe::Client.new(:token => ACCESS_TOKEN)
		people_count = @client.group(GROUP_ID).members.count
		@message = params[:text]

		if @message.split()[0] == '/location'
			Incomings.create(text: @message.split()[1..-1].join(' '))
		elsif @message.split()[0] == '/yo'
			Yo.create(username: @message.split()[1..-1].join(' '))
		end

		if(Incomings.all.count != 0)
			uri = URI('https://api.justyo.co/yo/')
			Yo.all.each do |yo|
				Net::HTTP.post_form(uri, api_token: YO_API_KEY, username: yo.username)
			end
		end

		if(Incomings.all.count == people_count)
			redirect_to :controller => 'cities', :action => 'index'
		else
			render :text => params.inspect
		end
	end
end
