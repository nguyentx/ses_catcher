require 'csv'

task :export_emails => :environment do
	csv_string = CSV.open("./ses_emails.csv", "wb") do |csv|
		Email.all.each do |email|
			csv << [email.address, email.status]
		end
	end
end
