# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ticket::Application.initialize!

require File.join(Rails.root, 'lib', 'referral.rb')