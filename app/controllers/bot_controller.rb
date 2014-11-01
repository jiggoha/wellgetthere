class BotController < ApplicationController
	BASE_URL = "https://api.groupme.com/v3"
	GROUP_ID = "10871334"
	BOT_ID_GetMeThere = "6be96bc289b91398ee1c84362d"
	BOT_ID_JIMGYM = "53a81761fcf30e3146a9957c5a"

	def index
		# @client = GroupMe::Client.new(:token => ACCESS_TOKEN)

		# noMeaningfulMessage = true
		# while(noMeaningfulMessage)
		# 	noNewMessage = true
		# 	@messages_number = @client.messages_count(GROUP_ID)

		# 	while(noNewMessage)
		# 		if(@messages_number < @client.messages_count(GROUP_ID))
		# 			if @client.messages(GROUP_ID)[0][:text] == '/test'
		# 				noMeaningfulMessage = false
		# 			end
		# 				noNewMessage = false
		# 		end
		# 	sleep(0.5)
		# 	end
		# end
	end

	def callback
		@text = params["text"]
		render :text => params.inspect
	end
end
