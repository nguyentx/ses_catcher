require 'open-uri'

class EmailsController < ApplicationController

	def show
	end

	def process_ses_notification
		data = JSON.parse( request.raw_post )
		if data["Type"] == "SubscriptionConfirmation" # Handle initial subscription request from Amazon SNS so that the server is authorized to receive the JSON complaints
			open( data["SubscribeURL"] ).readlines
			redirect_to root_path
		elsif data["Type"] == "Notification"
			message = JSON.parse( data["Message"])
			if message["notificationType"] == "Bounce" 
				bounced_email = message["bounce"]["bouncedRecipients"][0]["emailAddress"]
				Email.find_or_create_by_address( address: bounced_email, status: 'bounced' )
				# todo Process bounced email
			elsif message["notificationType"] == "Complaint" 
				unsubscribe_email = message["complaint"]["complainedRecipients"][0]["emailAddress"]
				Email.find_or_create_by_address( address: unsubscribe_email, status: 'unsubscribed' )
			end
		end

	end

end
