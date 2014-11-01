class BotController < ApplicationController

	def index
		
		@client = GroupMe::Client.new(:token => ACCESS_TOKEN)
		people_count = @client.group(GROUP_ID).members.count

		not_all_replied = true
		replies = 0
		@locations = []
		@yoUserNames = []
		

		while(not_all_replied)
			not_meaningful_message = true
			@messages_number = Incomings.count

			while(not_meaningful_message)

				if(@messages_number < Incomings.count)
					message = Incomings.first.text
					if message.split()[0] == '/location'
						@locations.push(message.split()[1..-1].join(' '))
						replies += 1
						Incomings.first.destroy

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
						Incomings.first.destroy
					else
						Incomings.first.destroy
					end
						not_meaningful_message = false
				end
				sleep (3)
			end
		end
		redirect_to :controller => 'cities', :action => 'index', :locations => @locations
	end

	def callback
		@text = params[:text]
		Incomings.create(text: @text)
	end
end
