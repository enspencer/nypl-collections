require 'json'
require 'httparty'
require './nypl_collections/configuration'
require 'pry'
require 'dotenv'
Dotenv.load "../.env"

module Collections
  class Client
    include Collections::Configuration
    include HTTParty

    def initialize
      reset
    end

    def return_captures_for_uuid(options= {})
      token = auth_token

      if options == "withTitles"
        withTitles = "withTitles=yes"
      end

      HTTParty.get("http://api.repo.nypl.org/api/v1/items/5fa75050-c6c7-012f-e24b-58d385a7bc34?#{withTitles}",
        :headers => {
          "Authorization" => "Token token=#{token}"
        })
    end

  end
end



@client = Collections::Client.new
@client.configure do |config|
  config.auth_token = ENV['AUTH_TOKEN']
end

puts @client.return_captures_for_uuid("withTitles")
binding.pry