class BotController < ApplicationController
	BASE_URL = "https://api.groupme.com/v3"
	GROUP_ID = "10871334"
	BOT_ID_GetMeThere = "6be96bc289b91398ee1c84362d"
	BOT_ID_JIMGYM = "53a81761fcf30e3146a9957c5a"

	def index
		
		@client = GroupMe::Client.new(:token => ACCESS_TOKEN)
		people_count = @client.group(GROUP_ID).members.count

		not_all_replied = true
		replies = 0
		@locations = []
		@yoUserNames = []

		while(not_all_replied)
			not_meaningful_message = true
			@messages_number = @client.messages_count(GROUP_ID)

			while(not_meaningful_message)

				if(@messages_number < @client.messages_count(GROUP_ID))
					message = @client.messages(GROUP_ID)[0][:text]
					if message.split()[0] == '/location'
						@locations.push(message.split()[1..-1].join(' '))

						replies += 1

						if replies == 1 and !@yoUserNames.empty?
							uri = URI('https://api.justyo.co/yo/')
							@yoUserNames.each do |yoUserName|
								Net::HTTP.post_form(uri, api_token: YO_API_KEY, username: yoUserName)
							end
						end
						if replies == people_count
							not_all_replied = false
						end
					elsif message.split()[0] == '/yo'
						@yoUserNames.push(message.split()[1..-1].join(' '))	
					end
						not_meaningful_message = false
				end
			sleep(0.5)
			end
		end

	end

	def callback
		# @text = params[:text]
		# if @text == '/test'
		# 	redirect_to :controller => 'bot', :action => 'index'
		# else 
		# 	sleep(1)
		# 	redirect_to :controller => 'bot', :action => 'callback'
		# end
	end
end
