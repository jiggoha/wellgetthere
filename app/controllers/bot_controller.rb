class BotController < ApplicationController

	def index
	end

	def callback
		@client = GroupMe::Client.new(:token => ACCESS_TOKEN)
		people_count = @client.group(GROUP_ID).members.count
		@message = params[:text]

		if @message.split()[0] == '\\location'
			Incomings.create(text: @message.split()[1..-1].join(' '))
		elsif @message.split()[0] == '\\yo'
			Yo.create(username: @message.split()[1..-1].join(' '))
		elsif @message.start_with?('\\hi')
			uri = URI(BASE_URL + '/bots/post')
			Net::HTTP.post_form(uri, {bot_id: BOT_ID_GetMeThere, text: "Time for a road trip! Tell me your location so I can figure out the best place for everyone to meet. “I can’t make it” is not an acceptable answer. (Begin your answer with /location, followed by your city.)"})
		elsif @message.start_with?('\\help')
			uri = URI(BASE_URL + '/bots/post')
			Net::HTTP.post_form(uri, {bot_id: BOT_ID_GetMeThere,
									  text: "Here's all the commands you can give me:
									  		\n\\hi: Start planning a trip. 	
									  		\n\\yo <username>: Add a username to be notified by Yo of all messages in the chat."})
			Net::HTTP.post_form(uri, {bot_id: BOT_ID_GetMeThere, text:
									        "\n\\location <your location>: tell me your location so I can plan the trip.
									        \n\\startover: if you guys really messed up, let me know and we'll start the whole thing over."})
		elsif @message.start_with?('\\startover')
			Incomings.all.each do |incoming|
				incoming.destroy
			end							
		end
		# Once one person has answered, everyone signed up for yo gets a yo as a reminder
		if(Incomings.all.count != 0)
			Yo.all.each do |yo|
				uri = URI.parse('https://api.justyo.co/yo/')
				req = Net::HTTP::Post.new(uri.path)
				req.set_form_data({ api_token: YO_API_KEY, username: yo.username})
				http = Net::HTTP.new(uri.host, uri.port)
				http.use_ssl = true
				response = http.request(req)
			end
		end
		if(Incomings.all.count == people_count)
			redirect_to "/cities/index"
		else
			render :text => params.inspect
		end
	end
end
