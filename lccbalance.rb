require 'csv'
require 'net/http'
require 'uri'
require 'rexml/document'
include REXML

uri = URI("https://litecoinca.sh/index.php")

# Replace the filename with the csv you have your public keys in.
# Currently expecting the CSV format from https://github.com/iancoleman/bip39
CSV.foreach("lccaddress.csv") do |row|
	# Use the form on the frontpage to perform the balance check.
	response = Net::HTTP.post_form(uri, 'ltcAddress' => row[1])
	# If the response markup changes, alter the regex.
	balance = /<\/strong>\s(\d+)\sLCC/.match(response.body)
	# Print all public keys with the balance.
	p row[1] + " Balance: " + balance[1] + " LCC"
	sleep 1 # To avoid overloading the remote.
end